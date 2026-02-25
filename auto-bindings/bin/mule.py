from clang.cindex import Index
from codegen.arena import Arena


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena.from_cursor(tu.cursor)
    print(arena.render_zig())


if __name__ == "__main__":
    # main("tmp/c.h")
    main("../../rocksdb/include/rocksdb/c.h")
