# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "libclang>=18.1.1",
# ]
# ///
from dataclasses import dataclass
from functools import cached_property

from clang.cindex import Cursor, CursorKind, Index, Type, TypeKind

HEADER = "../../rocksdb/include/rocksdb/c.h"


def cursor_kind_name(kind: CursorKind) -> str:
    if kind.is_attribute():
        return "attribute"
    elif kind.is_declaration():
        return "declaration"
    elif kind.is_expression():
        return "expression"
    elif kind.is_invalid():
        return "invalid"
    elif kind.is_preprocessing():
        return "preprocessing"
    elif kind.is_reference():
        return "reference"
    elif kind.is_statement():
        return "statement"
    elif kind.is_translation_unit():
        return "translation_unit"
    elif kind.is_unexposed():
        return "unexposed"
    else:
        return "unknown"


def cursor_name(cursor: Cursor) -> str:
    if cursor.is_abstract_record():
        return "abstract_record"
    elif cursor.is_anonymous():
        return "anonymous"
    elif cursor.is_bitfield():
        return "bitfield"
    elif cursor.is_const_method():
        return "const_method"
    elif cursor.is_converting_constructor():
        return "converting_constructor"
    elif cursor.is_copy_assignment_operator_method():
        return "copy_assignment_operator_method"
    elif cursor.is_copy_constructor():
        return "copy_constructor"
    elif cursor.is_default_constructor():
        return "default_constructor"
    elif cursor.is_default_method():
        return "default_method"
    elif cursor.is_definition():
        return "definition"
    elif cursor.is_deleted_method():
        return "deleted_method"
    elif cursor.is_move_assignment_operator_method():
        return "move_assignment_operator_method"
    elif cursor.is_move_constructor():
        return "move_constructor"
    elif cursor.is_mutable_field():
        return "mutable_field"
    elif cursor.is_pure_virtual_method():
        return "pure_virtual_method"
    elif cursor.is_scoped_enum():
        return "scoped_enum"
    elif cursor.is_static_method():
        return "static_method"
    elif cursor.is_virtual_method():
        return "virtual_method"
    else:
        return "unknown"


DEBUG = False


@dataclass(kw_only=True, frozen=True)
class CursorWrapper:
    cursor: Cursor

    @cached_property
    def name(self) -> str:
        return self.cursor.spelling


@dataclass(kw_only=True, frozen=True)
class TypeWrapper:
    type: Type

    @cached_property
    def name(self) -> str:
        return self.type.spelling


@dataclass(kw_only=True, frozen=True)
class ArgWrapper(CursorWrapper):
    @cached_property
    def type(self) -> TypeWrapper:
        return TypeWrapper(type=self.cursor.type)


@dataclass(kw_only=True, frozen=True)
class FunctionProtoWrapper(CursorWrapper):
    @cached_property
    def return_type(self) -> TypeWrapper:
        return TypeWrapper(type=self.cursor.result_type)

    @cached_property
    def args(self) -> list[ArgWrapper]:
        return [ArgWrapper(cursor=cursor) for cursor in self.cursor.get_arguments()]


@dataclass(kw_only=True, frozen=True)
class TypedefWrapper(CursorWrapper):
    pass


def scan_source(cursor: Cursor, depth=0) -> None:
    match cursor.type.kind:
        case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
            decl = FunctionProtoWrapper(cursor=cursor)
            print(f"function: {decl.name}")
            print(f"  return: {decl.return_type.name}")
            for arg in decl.args:
                print(f"     arg: {arg.type.name} {arg.name}")
            print()
        case TypeKind.TYPEDEF:
            decl = TypedefWrapper(cursor=cursor)
            print(f"typedef {decl.name}")
            print()
        case _:
            for c in cursor.get_children():
                scan_source(c, depth + 1)


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    scan_source(tu.cursor)


if __name__ == "__main__":
    main(HEADER)
