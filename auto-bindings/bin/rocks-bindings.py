from typing import Generator

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


def foo(struct: Struct, t: SysType) -> SysType:
    match t:
        case PointerType(child=ExtType(name=name)):
            pass
    return t


def handle_to_wrapper_args(arena: Arena) -> None:
    for struct in arena.structs.values():
        for fn in struct.fns:
            # Capture generator in a list because we're going to be
            # slicing the args
            for index, arg in list(visit_zig_args(fn)):
                pass
            fn.merge_args()


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena.from_cursor(tu.cursor)

    add_struct_fields(arena)
    rename_args_to_avoid_shadowing(arena)
    handle_to_wrapper_args(arena)
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


if __name__ == "__main__":
    main("../../rocksdb/include/rocksdb/c.h")
