from codegen.arena import ArgGroup, ZigArg
from codegen.systype import IntType


class TestArgGroup:
    def test_split(self):
        u32 = IntType(is_const=False, signed=False, bits=32)
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
