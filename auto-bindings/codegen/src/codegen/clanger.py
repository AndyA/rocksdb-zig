import re

from clang.cindex import Type, TypeKind

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
