from dataclasses import dataclass
from enum import Enum
from typing import Generator, Optional

from clang.cindex import Index
from codegen.arena import Arena, ArgGroup, Fn, Struct, ZigArg
from codegen.systype import ExtType, IntType, PointerSize, PointerType, SysType


def rename_args_to_avoid_shadowing(arena: Arena) -> None:
    def unshadow(fn_names: set[str], name: str) -> str:
        if name in fn_names:
            return name + "_"
        return name

    def unshadow_zig(fn_names: set[str], arg: ZigArg) -> ZigArg:
        new_name = unshadow(fn_names, arg.name)
        if new_name == arg.name:
            return arg
        return ZigArg(name=new_name, arg_type=arg.arg_type)

    for struct in arena.structs.values():
        fn_names = {fn.zig_name for fn in struct.fns}
        for fn in struct.fns:
            new_args: list[ArgGroup] = []
            for ag in fn.args:
                new_args.append(
                    ArgGroup(
                        zig_args=[unshadow_zig(fn_names, arg) for arg in ag.zig_args],
                        api_args=[unshadow(fn_names, name) for name in ag.api_args],
                    )
                )
            fn.args = new_args


def visit_zig_args(fn: Fn) -> Generator[tuple[int, ZigArg], None, None]:
    index = 0
    for ag in fn.args:
        for arg in ag.zig_args:
            yield index, arg
            index += 1


def visit_zig_arg_slices(
    fn: Fn, span: int
) -> Generator[tuple[int, list[ZigArg]], None, None]:
    base = 0
    for ag in fn.args:
        for index in range(0, len(ag.zig_args) - span + 1):
            yield base + index, ag.zig_args[index : index + span]
        base += len(ag.zig_args)


def slice_to_ptr_len(arena: Arena) -> None:
    valid_pairs = {
        "begin_key/begin_keylen",
        "blob/len",
        "buffer/buffer_size",
        "end_key/end_key_len",
        "end_key/end_keylen",
        "k/klen",
        "key/key_len",
        "key/keylen",
        "key/klen",
        "limit_key/limit_key_len",
        "name/name_len",
        "start_key/start_key_len",
        "timestamp/timestamp_len",
        "trim_ts/trim_tslen",
        "ts/tslen",
        "ts/tslen",
        "ts_low/ts_lowlen",
        "val/vallen",
        "val/vlen",
    }

    def find_slice(fn: Fn) -> bool:
        for slice in visit_zig_arg_slices(fn, 2):
            match slice:
                case index, [
                    ZigArg(
                        name=ptr_name,
                        arg_type=PointerType(child=IntType(is_const=is_const, bits=8)),
                    ),
                    ZigArg(name=len_name, arg_type=IntType(bits=64)),
                ]:
                    if f"{ptr_name}/{len_name}" not in valid_pairs:
                        continue

                    ag = fn.args_group(index, index + 2)
                    ag.zig_args = [
                        ZigArg(
                            name=ptr_name,
                            arg_type=PointerType(
                                is_const=True,
                                child=IntType(
                                    is_const=is_const,
                                    signed=False,
                                    bits=8,
                                ),
                                size=PointerSize.SLICE,
                            ),
                        )
                    ]
                    ag.api_args = [
                        f"@ptrCast({ptr_name}.ptr)",
                        f"@intCast({ptr_name}.len)",
                    ]
                    return True
        return False

    for struct in arena.structs.values():
        for fn in struct.fns:
            while find_slice(fn):
                pass


def add_struct_fields(arena: Arena) -> None:
    for struct in arena.structs.values():
        if struct.is_free:
            continue

        struct.add_pre("const Self = @This();")
        struct.add_pre(f"ref: *{arena.api}.{struct.name},")

        struct.add_post(f"test {struct.zig_name} {'{'}")
        struct.add_post("comptime { std.testing.expectEqual(@sizeOf(Self), 8); }")
        struct.add_post("std.testing.refAllDecls(Self);")
        struct.add_post("}")


class WrapperType(ExtType): ...


class RefType(Enum):
    NO = 1
    VAR = 2
    CONST = 3


@dataclass(kw_only=True, frozen=True)
class Wrapped:
    new_type: SysType
    ref_type: RefType
    name: Optional[str] = None


def to_wrapper_type(struct: Struct, t: SysType, *, force_const=False) -> Wrapped:
    def wrapper_name(target: Struct) -> str:
        if id(struct) == id(target):
            return "Self"
        return target.zig_name

    match t:
        case PointerType(child=ExtType(is_const=is_const, name=name)):
            if target := struct.arena.structs.get(name):
                new_name = wrapper_name(target)

                if is_const or force_const:
                    return Wrapped(
                        new_type=WrapperType(is_const=False, name=new_name),
                        ref_type=RefType.CONST,
                        name=new_name,
                    )

                return Wrapped(
                    new_type=PointerType(
                        is_const=False,
                        size=PointerSize.ONE,
                        child=WrapperType(is_const=False, name=new_name),
                    ),
                    ref_type=RefType.VAR,
                    name=new_name,
                )

    return Wrapped(new_type=t, ref_type=RefType.NO)


def handle_to_wrapper(arena: Arena) -> None:
    for struct in arena.structs.values():
        for fn in struct.fns:
            # Capture generator in a list because we're going to be
            # slicing the args
            for index, arg in list(visit_zig_args(fn)):
                wrapped = to_wrapper_type(struct, arg.arg_type)
                if wrapped.ref_type != RefType.NO:
                    ag = fn.args_group(index, index + 1)
                    ag.zig_args[0].arg_type = wrapped.new_type
                    if wrapped.ref_type == RefType.CONST:
                        ag.api_args[0] = f"helpers.unwrap({ag.api_args[0]})"
                    else:
                        ag.api_args[0] = f"helpers.unwrap({ag.api_args[0]}.*)"
            ret = to_wrapper_type(struct, fn.ret_type, force_const=True)
            if ret.ref_type != RefType.NO:
                fn.ret_type = ret.new_type
                fn.call = f"helpers.wrap({ret.name}, {fn.call})"
            fn.merge_args()


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena.from_cursor(tu.cursor, api="api")

    add_struct_fields(arena)
    rename_args_to_avoid_shadowing(arena)
    handle_to_wrapper(arena)
    slice_to_ptr_len(arena)

    print(
        f"""
        const std = @import("std");
        const assert = std.debug.assert;

        const helpers = @import("./helpers.zig");

        const {arena.api} = @import("rocksdb");
        """
    )

    print(arena.render_zig())

    print(
        """
        test {
            std.testing.refAllDecls(@This());
        }
        """
    )


if __name__ == "__main__":
    main("../../rocksdb/include/rocksdb/c.h")
