from typing import Optional

from clang.cindex import Cursor, Index, PrintingPolicy, TypeKind


def find_decl(cursor: Cursor, name: str) -> Optional[Cursor]:
    if cursor.type.kind == TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
        if cursor.spelling == name:
            return cursor

    for child in cursor.get_children():
        if decl := find_decl(child, name):
            return decl

    return None


def dump_cursor(cursor: Cursor) -> None:
    print(f"{'access_specifier':<40s}", cursor.access_specifier)
    print(f"{'availability':<40s}", cursor.availability)
    print(f"{'brief_comment':<40s}", cursor.brief_comment)
    print(f"{'canonical':<40s}", cursor.canonical)
    print(f"{'displayname':<40s}", cursor.displayname)
    # print(f"{'enum_type':<40s}", cursor.enum_type)
    # print(f"{'enum_value':<40s}", cursor.enum_value)
    print(f"{'exception_specification_kind':<40s}", cursor.exception_specification_kind)
    print(f"{'extent':<40s}", cursor.extent)
    print(f"{'get_arguments()':<40s}", cursor.get_arguments())
    print(f"{'get_bitfield_width()':<40s}", cursor.get_bitfield_width())
    print(f"{'get_children()':<40s}", cursor.get_children())
    print(f"{'get_definition()':<40s}", cursor.get_definition())
    print(f"{'get_field_offsetof()':<40s}", cursor.get_field_offsetof())
    # print(f"{'get_included_file()':<40s}", cursor.get_included_file())
    print(f"{'get_num_template_arguments()':<40s}", cursor.get_num_template_arguments())
    print(f"{'get_tokens()':<40s}", cursor.get_tokens())
    print(f"{'get_usr()':<40s}", cursor.get_usr())
    print(f"{'hash':<40s}", cursor.hash)
    print(f"{'is_abstract_record()':<40s}", cursor.is_abstract_record())
    print(f"{'is_anonymous()':<40s}", cursor.is_anonymous())
    print(f"{'is_bitfield()':<40s}", cursor.is_bitfield())
    print(f"{'is_const_method()':<40s}", cursor.is_const_method())
    print(f"{'is_converting_constructor()':<40s}", cursor.is_converting_constructor())
    print(
        f"{'is_copy_assignment_operator_method()':<40s}",
        cursor.is_copy_assignment_operator_method(),
    )
    print(f"{'is_copy_constructor()':<40s}", cursor.is_copy_constructor())
    print(f"{'is_default_constructor()':<40s}", cursor.is_default_constructor())
    print(f"{'is_default_method()':<40s}", cursor.is_default_method())
    print(f"{'is_definition()':<40s}", cursor.is_definition())
    print(f"{'is_deleted_method()':<40s}", cursor.is_deleted_method())
    print(
        f"{'is_move_assignment_operator_method()':<40s}",
        cursor.is_move_assignment_operator_method(),
    )
    print(f"{'is_move_constructor()':<40s}", cursor.is_move_constructor())
    print(f"{'is_mutable_field()':<40s}", cursor.is_mutable_field())
    print(f"{'is_pure_virtual_method()':<40s}", cursor.is_pure_virtual_method())
    print(f"{'is_scoped_enum()':<40s}", cursor.is_scoped_enum())
    print(f"{'is_static_method()':<40s}", cursor.is_static_method())
    print(f"{'is_virtual_method()':<40s}", cursor.is_virtual_method())
    print(f"{'kind':<40s}", cursor.kind)
    print(f"{'lexical_parent':<40s}", cursor.lexical_parent)
    print(f"{'linkage':<40s}", cursor.linkage)
    print(f"{'location':<40s}", cursor.location)
    print(f"{'mangled_name':<40s}", cursor.mangled_name)
    print(f"{'objc_type_encoding':<40s}", cursor.objc_type_encoding)
    print(f"{'raw_comment':<40s}", cursor.raw_comment)
    print(f"{'referenced':<40s}", cursor.referenced)
    print(f"{'result_type':<40s}", cursor.result_type)
    print(f"{'semantic_parent':<40s}", cursor.semantic_parent)
    print(f"{'spelling':<40s}", cursor.spelling)
    print(f"{'storage_class':<40s}", cursor.storage_class)
    print(f"{'tls_kind':<40s}", cursor.tls_kind)
    print(f"{'translation_unit':<40s}", cursor.translation_unit)
    print(f"{'type':<40s}", cursor.type)
    print(f"{'underlying_typedef_type':<40s}", cursor.underlying_typedef_type)


def walk_cursor(cursor: Cursor, depth: int = 0) -> None:
    pad = "  " * depth
    pp: PrintingPolicy = PrintingPolicy.create(cursor)
    pretty = cursor.pretty_printed(pp)
    del pp
    print(f"{pad}{cursor.spelling} {cursor.kind} {pretty}")
    for child in cursor.get_children():
        walk_cursor(child, depth + 1)


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    if decl := find_decl(tu.cursor, "rocksdb_writebatch_wi_update_timestamps"):
        if False:
            args = list(decl.get_arguments())
            dump_cursor(args[4])
        else:
            walk_cursor(decl)


if __name__ == "__main__":
    main("../../rocksdb/include/rocksdb/c.h")
