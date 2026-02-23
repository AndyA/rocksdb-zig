import re
from dataclasses import dataclass
from functools import cached_property
from typing import Optional, Self

from clang.cindex import Cursor, Index, Type, TypeKind
from codegen.typesys import (
    ArrayType,
    ExtType,
    FloatType,
    FnType,
    IntType,
    PointerType,
    SysType,
    VoidType,
)


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
            return FloatType(is_const=is_const, bits=128)
        case TypeKind.POINTER:  # ty:ignore[unresolved-attribute]
            return PointerType(
                is_const=is_const,
                ref_type=parse_clang_type(ct.get_pointee()),
            )
        case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
            return FnType(
                is_const=is_const,
                arg_types=[parse_clang_type(t) for t in ct.argument_types()],
                ret_type=parse_clang_type(ct.get_result()),
            )
        case TypeKind.ELABORATED:  # ty:ignore[unresolved-attribute]
            return ExtType(
                is_const=is_const,
                name=re.sub(r"^const\s+", "", ct.spelling),
            )
        case TypeKind.INCOMPLETEARRAY:  # ty:ignore[unresolved-attribute]
            return ArrayType(
                is_const=is_const,
                child_type=parse_clang_type(ct.get_array_element_type()),
            )
        case TypeKind.VOID:  # ty:ignore[unresolved-attribute]
            return VoidType(is_const=is_const)
        case _:
            raise ValueError(f"Bad type {ct.spelling} ({ct.kind.value})")


def refers_to(st: SysType) -> Optional[str]:
    match st:
        case ExtType(name=name):
            return name
        case PointerType(ref_type=ExtType(name=name)):
            return name
        case _:
            return None


@dataclass(kw_only=True, frozen=True)
class Fn:
    arena: "Arena"
    name: str
    arg_names: tuple[str]
    fn: FnType

    @cached_property
    def belongs_to(self) -> Optional[str]:
        possible = []
        # Does it construct a handle?
        if cons := self.arena.refs(self.fn.ret_type):
            possible.append(cons)
        # Does it take a handle as its first argument?
        if len(self.fn.arg_types) > 0:
            if this := self.arena.refs(self.fn.arg_types[0]):
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
        # Give up
        return None


@dataclass(kw_only=True, frozen=True)
class Arena:
    handles: set[str]
    fndefs: list[tuple[str, FnType, tuple[str]]]

    def refs(self, systype: SysType) -> Optional[str]:
        if ref := refers_to(systype):
            if ref in self.handles:
                return ref
        return None

    @classmethod
    def from_cursor(cls, cursor: Cursor) -> Self:
        handles: set[str] = set()
        fndefs: list[tuple[str, FnType, tuple[str]]] = []

        def scan(cursor: Cursor) -> None:
            match cursor.type.kind:
                case TypeKind.TYPEDEF:  # ty:ignore[unresolved-attribute]
                    handles.add(cursor.spelling)
                case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
                    fn = parse_clang_type(cursor.type)
                    assert isinstance(fn, FnType)
                    arg_names = tuple(arg.spelling for arg in cursor.get_arguments())
                    fndefs.append((cursor.spelling, fn, arg_names))
                case _:
                    for child in cursor.get_children():
                        scan(child)

        scan(cursor)

        return cls(handles=handles, fndefs=fndefs)

    @cached_property
    def fns(self) -> list[Fn]:
        return [
            Fn(arena=self, name=name, arg_names=arg_names, fn=fn)
            for name, fn, arg_names in self.fndefs
        ]

    @cached_property
    def structs(self) -> dict[str, list[Fn]]:
        idx: dict[str, list[Fn]] = {}
        for fn in self.fns:
            ref = fn.belongs_to or "_"
            idx.setdefault(ref, []).append(fn)
        return idx


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    bindings = Arena.from_cursor(tu.cursor)
    for struct, fns in bindings.structs.items():
        print(f"{struct}:")
        for fn in fns:
            print(f"  {fn.name}({', '.join(fn.arg_names)}) -> {fn.fn.ret_type}")


if __name__ == "__main__":
    # main("tmp/c.h")
    main("../../rocksdb/include/rocksdb/c.h")
