import re
from dataclasses import dataclass
from typing import Self

from clang.cindex import Cursor, Index, Type, TypeKind
from codegen.typesys import (
    ArrayType,
    ExtType,
    FloatType,
    FnNamedArgsType,
    FnType,
    IntType,
    PointerType,
    SysType,
    VoidType,
)


def parse_clang_type(type: Type) -> SysType:
    is_const = type.is_const_qualified()
    match type.kind:
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
                ref_type=parse_clang_type(type.get_pointee()),
            )
        case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
            return FnType(
                is_const=is_const,
                arg_types=[parse_clang_type(t) for t in type.argument_types()],
                ret_type=parse_clang_type(type.get_result()),
            )
        case TypeKind.ELABORATED:  # ty:ignore[unresolved-attribute]
            return ExtType(
                is_const=is_const,
                name=re.sub(r"^const\s+", "", type.spelling),
            )
        case TypeKind.INCOMPLETEARRAY:  # ty:ignore[unresolved-attribute]
            return ArrayType(
                is_const=is_const,
                child_type=parse_clang_type(type.get_array_element_type()),
            )
        case TypeKind.VOID:  # ty:ignore[unresolved-attribute]
            return VoidType(is_const=is_const)
        case _:
            raise ValueError(f"Bad type {type.spelling} ({type.kind.value})")


@dataclass(kw_only=True, frozen=True)
class Bindings:
    typedefs: list[str]
    functions: dict[str, FnNamedArgsType]

    @classmethod
    def from_cursor(cls, cursor: Cursor) -> Self:
        typedefs: list[str] = []
        functions: dict[str, FnNamedArgsType] = {}

        def scan(cursor: Cursor) -> None:
            match cursor.type.kind:
                case TypeKind.TYPEDEF:  # ty:ignore[unresolved-attribute]
                    typedefs.append(cursor.spelling)
                case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
                    name = cursor.spelling
                    fn = parse_clang_type(cursor.type)
                    assert isinstance(fn, FnType)
                    st = FnNamedArgsType(
                        is_const=fn.is_const,
                        arg_names=[arg.spelling for arg in cursor.get_arguments()],
                        arg_types=fn.arg_types,
                        ret_type=fn.ret_type,
                    )
                    functions[name] = st
                case _:
                    for child in cursor.get_children():
                        scan(child)

        scan(cursor)

        return cls(typedefs=typedefs, functions=functions)


def scan_source(cursor: Cursor) -> None:
    match cursor.type.kind:
        case TypeKind.TYPEDEF:  # ty:ignore[unresolved-attribute]
            print(f"# {cursor.spelling}")
            st = parse_clang_type(cursor.type)
            print(f"{st},")
        case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
            print(f"# {cursor.spelling}")
            fn = parse_clang_type(cursor.type)
            assert isinstance(fn, FnType)
            st = FnNamedArgsType(
                is_const=fn.is_const,
                arg_names=[arg.spelling for arg in cursor.get_arguments()],
                arg_types=fn.arg_types,
                ret_type=fn.ret_type,
            )
            print(f"{st},")
        case _:
            for child in cursor.get_children():
                scan_source(child)


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    bindings = Bindings.from_cursor(tu.cursor)
    print(bindings.functions)


if __name__ == "__main__":
    # main("tmp/c.h")
    main("../../rocksdb/include/rocksdb/c.h")
