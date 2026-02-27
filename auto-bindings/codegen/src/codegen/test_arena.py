import pytest
from clang.cindex import Index

from codegen.arena import Arena, ArgGroup, ZigArg
from codegen.systype import ExtType, IntType, PointerSize, PointerType, SysType

ci8 = IntType(is_const=True, signed=True, bits=8)
i8 = IntType(is_const=False, signed=True, bits=8)
u32 = IntType(is_const=False, signed=False, bits=32)
ci64 = IntType(is_const=False, signed=True, bits=64)


def ptr(child: SysType):
    return PointerType(
        is_const=False,
        child=child,
        size=PointerSize.C,
        sentinel=None,
    )


def cptr(child: SysType):
    return PointerType(
        is_const=True,
        child=child,
        size=PointerSize.C,
        sentinel=None,
    )


def ext(name: str) -> ExtType:
    return ExtType(is_const=False, name=name, namespace="api")


def cext(name: str) -> ExtType:
    return ExtType(is_const=True, name=name, namespace="api")


@pytest.fixture
def arena() -> Arena:
    idx = Index.create()
    tu = idx.parse("ref/c.h")
    arena = Arena.from_cursor(tu.cursor)
    return arena


class TestArgGroup:
    def test_split(self) -> None:
        ag = ArgGroup(
            zig_args=[
                ZigArg(name="a", arg_type=u32),
                ZigArg(name="b", arg_type=u32),
                ZigArg(name="c", arg_type=u32),
            ],
            api_args=["a", "b", "c"],
        )

        ag1 = ArgGroup(
            zig_args=[ZigArg(name="a", arg_type=u32)],
            api_args=["a"],
        )

        ag2 = ArgGroup(
            zig_args=[
                ZigArg(name="b", arg_type=u32),
                ZigArg(name="c", arg_type=u32),
            ],
            api_args=["b", "c"],
        )

        assert ag.split(0) == [ag]
        assert ag.split(3) == [ag]
        assert ag.split(1) == [ag1, ag2]


class TestFn:
    def test_args_group(self, arena: Arena):
        fn = arena.get_fn("rocksdb_put")

        zig_args1 = [
            ZigArg(name="db", arg_type=ptr(ext("rocksdb_t"))),
            ZigArg(name="options", arg_type=ptr(cext("rocksdb_writeoptions_t"))),
        ]

        zig_args2 = [
            ZigArg(name="key", arg_type=ptr(ci8)),
            ZigArg(name="keylen", arg_type=ci64),
        ]

        zig_args3 = [
            ZigArg(name="val", arg_type=ptr(ci8)),
            ZigArg(name="vallen", arg_type=ci64),
        ]

        zig_args4 = [
            ZigArg(name="errptr", arg_type=ptr(ptr(i8))),
        ]

        api_args1 = ["db", "options"]
        api_args2 = ["key", "keylen"]
        api_args3 = ["val", "vallen"]
        api_args4 = ["errptr"]

        all_args = [
            ArgGroup(
                zig_args=[*zig_args1, *zig_args2, *zig_args3, *zig_args4],
                api_args=[*api_args1, *api_args2, *api_args3, *api_args4],
            )
        ]

        assert fn.args == all_args

        split1_args = [
            ArgGroup(zig_args=zig_args1, api_args=api_args1),
            ArgGroup(zig_args=zig_args2, api_args=api_args2),
            ArgGroup(
                zig_args=[*zig_args3, *zig_args4],
                api_args=[*api_args3, *api_args4],
            ),
        ]

        key_args = fn.args_group(2, 4)
        assert key_args == ArgGroup(zig_args=zig_args2, api_args=api_args2)
        assert fn.args == split1_args

        split2_args = [
            ArgGroup(zig_args=zig_args1, api_args=api_args1),
            ArgGroup(zig_args=zig_args2, api_args=api_args2),
            ArgGroup(zig_args=zig_args3, api_args=api_args3),
            ArgGroup(zig_args=zig_args4, api_args=api_args4),
        ]

        val_args = fn.args_group(4, 6)
        assert val_args == ArgGroup(zig_args=zig_args3, api_args=api_args3)
        assert fn.args == split2_args

        key_args2 = fn.args_group(2, 4)
        assert key_args2 == key_args
        assert fn.args == split2_args

        fn.merge_args()
        assert fn.args == all_args
