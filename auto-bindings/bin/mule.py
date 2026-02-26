from typing import Generator

from clang.cindex import Index
from codegen.arena import Arena, ArgGroup, Fn, ZigArg
from codegen.systype import IntType, PointerSize, PointerType, SysType


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


def visit_zig_args(
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
        for slice in visit_zig_args(fn, 2):
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
        struct.add_top_matter("const Self = @This();\n")
        struct.add_top_matter("comptime {assert(@sizeOf(Self) == 8);}\n")
        struct.add_top_matter(f"ref: *{arena.api}.{struct.name},")


def handle_to_wrapper(arena: Arena, t: SysType) -> SysType:
    return t


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena.from_cursor(tu.cursor)

    add_struct_fields(arena)
    rename_args_to_avoid_shadowing(arena)
    slice_to_ptr_len(arena)

    print(
        f"""
        const std = @import("std");
        const assert = std.debug.assert;

        const {arena.api} = @import("rocksdb");
        """
    )

    print(arena.render_zig())


if __name__ == "__main__":
    main("../../rocksdb/include/rocksdb/c.h")
