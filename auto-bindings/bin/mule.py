import re
from dataclasses import dataclass
from functools import cached_property
from typing import Optional, Self

from clang.cindex import Cursor, Index, Type, TypeKind
from codegen.systype import (
    ExtType,
    FloatType,
    FnType,
    IntType,
    PointerSize,
    PointerType,
    SysType,
    VoidType,
)
from codegen.tools import camel_case, common_prefix, pascal_case


def parse_clang_type(ct: Type) -> SysType:
    is_const = ct.is_const_qualified()
    match ct.kind:
        case TypeKind.CHAR_S:  # ty:ignore[unresolved-attribute]
            return IntType(is_const=is_const, signed=True, bits=8)
        case TypeKind.UCHAR | TypeKind.CHAR_U:  # ty:ignore[unresolved-attribute]
            return IntType(is_const=is_const, signed=False, bits=8)
        case TypeKind.INT:  # ty:ignore[unresolved-attribute]
            return IntType(is_const=is_const, signed=True, bits=64)
        case TypeKind.UINT:  # ty:ignore[unresolved-attribute]
            return IntType(is_const=is_const, signed=False, bits=64)
        case TypeKind.FLOAT:  # ty:ignore[unresolved-attribute]
            return FloatType(is_const=is_const, bits=32)
        case TypeKind.DOUBLE:  # ty:ignore[unresolved-attribute]
            return FloatType(is_const=is_const, bits=64)
        case TypeKind.LONGDOUBLE:  # ty:ignore[unresolved-attribute]
            return FloatType(is_const=is_const, bits=80)
        case TypeKind.POINTER:  # ty:ignore[unresolved-attribute]
            return PointerType(
                is_const=is_const,
                child=parse_clang_type(ct.get_pointee()),
                size=PointerSize.C,
            )
        case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
            return FnType(
                is_const=is_const,
                arg_types=[parse_clang_type(t) for t in ct.argument_types()],
                ret_type=parse_clang_type(ct.get_result()),
            )
        case TypeKind.INCOMPLETEARRAY:  # ty:ignore[unresolved-attribute]
            return PointerType(
                is_const=is_const,
                child=parse_clang_type(ct.get_array_element_type()),
                size=PointerSize.MANY,
            )
        case TypeKind.ELABORATED:  # ty:ignore[unresolved-attribute]
            return ExtType(
                is_const=is_const,
                name=re.sub(r"^const\s+", "", ct.spelling),
            )
        case TypeKind.VOID:  # ty:ignore[unresolved-attribute]
            return VoidType(is_const=is_const)
        case _:
            raise ValueError(f"Bad type {ct.spelling} ({ct.kind.value})")


def render_zig_type_no_const(t: SysType) -> str:
    match t:
        case IntType(bits=bits, signed=False):
            return f"u{bits}"
        case IntType(bits=bits, signed=True):
            return f"i{bits}"
        case FloatType(bits=bits):
            return f"f{bits}"
        case VoidType():
            return "void"
        case ExtType(name=name):
            return f"api.{name}"
        case FnType(arg_types=arg_types, ret_type=ret_type):
            args = ", ".join([render_zig_type(t) for t in arg_types])
            ret = render_zig_type(ret_type)
            return f"fn ({args},) {ret} "
        case PointerType(child=VoidType(is_const=is_const)):
            if is_const:
                return "*const anyopaque"
            else:
                return "*anyopaque"
        case PointerType(child=child, sentinel=None):
            match t.size:
                case PointerSize.C:
                    return "[*c]" + render_zig_type(child)
                case PointerSize.ONE:
                    return "*" + render_zig_type(child)
                case PointerSize.MANY:
                    return "[*]" + render_zig_type(child)
                case PointerSize.SLICE:
                    return "[]" + render_zig_type(child)
        case PointerType(child=child, sentinel=sentinel):
            match t.size:
                case PointerSize.MANY:
                    return f"[*:{sentinel}]" + render_zig_type(child)
                case PointerSize.SLICE:
                    return f"[:{sentinel}]" + render_zig_type(child)

    raise ValueError(f"Can't zig {t}")


def render_zig_type(t: SysType) -> str:
    if t.is_const:
        return "const " + render_zig_type_no_const(t)
    else:
        return render_zig_type_no_const(t)


def refers_to(st: SysType) -> Optional[str]:
    match st:
        case ExtType(name=name):
            return name
        case PointerType(child=ExtType(name=name)):
            return name
        case _:
            return None


def comma_if_longer(source: str, maxlen: int) -> str:
    if len(source) < maxlen:
        return source
    return source + ","


@dataclass(kw_only=True, frozen=True)
class ZigArg:
    name: str
    arg_type: SysType

    def render_zig(self) -> str:
        return self.name + ": " + render_zig_type_no_const(self.arg_type)


@dataclass(kw_only=True, frozen=True)
class ArgGroup:
    zig_args: list[ZigArg]
    api_args: list[str]

    def split(self, index: int) -> list["ArgGroup"]:
        size = len(self.zig_args)
        if size != len(self.api_args):
            raise ValueError("Can't split a non-rectangular ArgGroup")
        if index < 0 or index > size:
            raise ValueError(f"Index {index} out of range 0 - {size}")
        if index == 0 or index == size:
            return [self]

        return [
            ArgGroup(zig_args=self.zig_args[0:index], api_args=self.api_args[0:index]),
            ArgGroup(zig_args=self.zig_args[index:], api_args=self.api_args[index:]),
        ]


type FnDef = tuple[str, FnType, tuple[str, ...]]


@dataclass(kw_only=True)
class Fn:
    arena: "Arena"
    name: str
    args: list[ArgGroup]
    ret_type: SysType
    public: bool = True

    @classmethod
    def from_fndef(cls, *, arena: "Arena", fndef: FnDef):
        name, fn, arg_names = fndef
        assert len(arg_names) == len(fn.arg_types)
        zig_args = [
            ZigArg(name=arg_name, arg_type=arg_type)
            for arg_name, arg_type in zip(arg_names, fn.arg_types)
        ]
        args = [ArgGroup(zig_args=zig_args, api_args=list(arg_names))]

        return cls(arena=arena, name=name, args=args, ret_type=fn.ret_type)

    def first_arg_type(self) -> Optional[SysType]:
        if len(self.args) == 0:
            return None
        if len(self.args[0].zig_args) == 0:
            return None
        return self.args[0].zig_args[0].arg_type

    @cached_property
    def belongs_to(self) -> str:
        possible = []
        # Does it construct a handle?
        if cons := self.arena.refs(self.ret_type):
            possible.append(cons)

        # Does it take a handle as its first argument?
        if this_type := self.first_arg_type():
            if this := self.arena.refs(this_type):
                possible.append(this)

        # Match against the longest handle type name
        longest = sorted(possible, key=lambda s: (len(s), s), reverse=True)
        for name in longest:
            if name.endswith("_t"):
                if self.name.startswith(name[:-1]):
                    return name

        # Otherwise return constructors first, then methods
        if len(possible) > 0:
            return possible[0]

        # Give up; _ is the catch all namespace for free fns
        return "_"

    @cached_property
    def struct(self) -> "Struct":
        if struct := self.arena.structs.get(self.belongs_to):
            return struct
        assert False

    @cached_property
    def local_name(self) -> str:
        prefixes: list[str] = [self.struct.prefix]
        if self.belongs_to.endswith("_t"):
            prefixes.append(self.belongs_to[:-2])
        prefixes.sort(key=lambda s: (len(s), s), reverse=True)

        for prefix in prefixes:
            if self.name.startswith(prefix + "_"):
                return self.name[len(prefix) + 1 :]

        return self.name

    @cached_property
    def zig_name(self) -> str:
        return camel_case(self.local_name)

    def render_zig(self) -> str:
        pub = "pub " if self.public else ""
        ret = render_zig_type_no_const(self.ret_type)
        fn_args = comma_if_longer(
            ", ".join([arg.render_zig() for ag in self.args for arg in ag.zig_args]),
            70 - len(self.zig_name) - len(ret),
        )
        call_args = comma_if_longer(
            ", ".join([arg for ag in self.args for arg in ag.api_args]),
            70 - len(self.name),
        )
        hdr = f"{pub}fn {self.zig_name}({fn_args}) {ret} " + "{"
        call = f"api.{self.name}({call_args});"
        ftr = "}"
        return f"{hdr}\n{call}\n{ftr}"

    def find_arg(self, index: int) -> tuple[int, int]:
        """
        Given an arg index (which indexes into the called api function's args)
        return a tuple containing the index of the containing ArgGroup and the
        arg's index within that group. It is an error to reference out of range
        args.
        """
        arg_index = index
        for group_index, group in enumerate(self.args):
            if arg_index < len(group.zig_args):
                return group_index, arg_index
            arg_index -= len(group.zig_args)

        raise ValueError(f"Arg index {index} out of range")

    # Useful mutations
    def group_args(self, start: int, end: int) -> ArgGroup:
        """
        Given an range of args as start, count combine those args into a
        single group and return that group. If they are currently in a matching
        group return that group. If they are currently grouped incompatibly raise
        an error.
        """

        def contig(sgi: int, sai: int, egi: int, eai: int) -> bool:
            return egi == sgi or (egi == sgi + 1 and eai == 0)

        assert end > start
        sgi, sai = self.find_arg(start)
        egi, eai = self.find_arg(end)

        if not contig(sgi, sai, egi, eai):
            raise ValueError(f"Range {start} - {end} spans multiple groups")

        # Split group at start index - which is a nop if the index is zero -
        # and recompute sgi, sai, egi, eai
        self.args[sgi : sgi + 1] = self.args[sgi].split(sai)
        sgi, sai = self.find_arg(start)
        egi, eai = self.find_arg(end)

        assert contig(sgi, sai, egi, eai)

        # Split group at end index - which is a nop if the index is at the end
        # of the group and recompute again
        self.args[sgi : sgi + 1] = self.args[sgi].split(eai)
        sgi, sai = self.find_arg(start)
        egi, eai = self.find_arg(end)

        assert contig(sgi, sai, egi, eai)

        group = self.args[sgi]
        assert len(group.api_args) == end - start

        return group


@dataclass(kw_only=True)
class Struct:
    arena: "Arena"
    name: str
    fns: list[Fn]

    @cached_property
    def prefix(self) -> str:
        names = [fn.name for fn in self.fns]
        return common_prefix(names)

    @cached_property
    def base_name(self) -> str:
        if self.name.endswith("_t"):
            return self.name[:-2]
        return self.name

    @cached_property
    def is_free(self) -> bool:
        return self.name == "_"

    @cached_property
    def zig_name(self) -> str:
        if self.is_free:
            return self.name
        return pascal_case(self.base_name)

    def render_zig(self) -> str:
        body = "\n\n".join([fn.render_zig() for fn in self.fns])
        if self.is_free:
            return f"{body}\n"
        return f"pub const {self.zig_name} = struct " + "{\n" + body + "};\n"


@dataclass(kw_only=True, frozen=True)
class Arena:
    handles: set[str]
    fndefs: list[FnDef]

    def refs(self, systype: SysType) -> Optional[str]:
        if ref := refers_to(systype):
            if ref in self.handles:
                return ref
        return None

    @classmethod
    def from_cursor(cls, cursor: Cursor) -> Self:
        handles: set[str] = set()
        fndefs: list[FnDef] = []

        def safe_name(cursor: Cursor, index: int) -> str:
            name = str(cursor.spelling)
            if len(name):
                return name
            return f"arg{index}"

        def scan(cursor: Cursor) -> None:
            match cursor.type.kind:
                case TypeKind.TYPEDEF:  # ty:ignore[unresolved-attribute]
                    handles.add(cursor.spelling)
                case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
                    fn = parse_clang_type(cursor.type)
                    assert isinstance(fn, FnType)
                    arg_names = tuple(
                        safe_name(arg, i)
                        for i, arg in enumerate(cursor.get_arguments())
                    )
                    fndefs.append((str(cursor.spelling), fn, arg_names))
                case _:
                    for child in cursor.get_children():
                        scan(child)

        scan(cursor)

        return cls(handles=handles, fndefs=fndefs)

    @cached_property
    def fns(self) -> list[Fn]:
        return [Fn.from_fndef(arena=self, fndef=fndef) for fndef in self.fndefs]

    @cached_property
    def structs(self) -> dict[str, Struct]:
        idx: dict[str, list[Fn]] = {}
        for fn in self.fns:
            idx.setdefault(fn.belongs_to, []).append(fn)
        return {
            name: Struct(
                arena=self,
                name=name,
                fns=fns,
            )
            for name, fns in idx.items()
        }

    def render_zig(self) -> str:
        body = "\n".join(
            [self.structs[name].render_zig() for name in sorted(self.structs.keys())]
        )
        return f'const api = @import("rocksdb");\n\n{body}'


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena.from_cursor(tu.cursor)
    print(arena.render_zig())


if __name__ == "__main__":
    # main("tmp/c.h")
    main("../../rocksdb/include/rocksdb/c.h")
