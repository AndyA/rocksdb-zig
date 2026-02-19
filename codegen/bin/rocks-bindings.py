import re
from dataclasses import dataclass, field
from functools import cached_property, reduce
from typing import Optional

from clang.cindex import Cursor, Index, Type, TypeKind


def common_prefix(names: list[str]) -> str:
    def common(a: list[str], b: list[str]) -> list[str]:
        lim = min(len(a), len(b))
        for i in range(lim):
            if a[i] != b[i]:
                return a[:i]
        return a[:lim]

    assert len(names) > 0
    parts = [n.split("_") for n in names]
    prefix = reduce(common, parts)
    return "_".join(prefix)


def pascal_case(name: str) -> str:
    return "".join([part.title() for part in name.split("_")])


def camel_case(name: str) -> str:
    if name == "":
        return name
    pascal = pascal_case(name)
    return pascal[0:1].lower() + pascal[1:]


@dataclass(kw_only=True, frozen=True)
class CursorWrapper:
    arena: "Arena"
    cursor: Cursor

    @cached_property
    def name(self) -> str:
        return self.cursor.spelling


@dataclass(kw_only=True, frozen=True)
class TypedefWrapper(CursorWrapper):
    @cached_property
    def constructors(self) -> list["FunctionProtoWrapper"]:
        return sorted(
            self.arena.constructor_index.get(self.name, []),
            key=lambda fn: fn.name,
        )

    @cached_property
    def methods(self) -> list["FunctionProtoWrapper"]:
        return sorted(
            self.arena.method_index.get(self.name, []), key=lambda fn: fn.name
        )

    @cached_property
    def class_name(self) -> str:
        if self.name.endswith("_t"):
            return self.name[:-1]
        return self.name + "_"

    @cached_property
    def prefix(self) -> Optional[str]:
        names = [fn.name for fn in (*self.constructors, *self.methods)]
        if names:
            return common_prefix(names) + "_"
        return None

    @cached_property
    def zig_name(self) -> str:
        return pascal_case(self.class_name[:-1])


@dataclass(kw_only=True, frozen=True)
class TypeWrapper:
    arena: "Arena"
    type: Type

    @cached_property
    def full_name(self) -> str:
        return self.type.spelling

    @cached_property
    def name(self) -> str:
        return re.sub(r"^const\s+", "", self.full_name)

    def const(self) -> bool:
        # return self.full_name.startswith("const ")
        return self.type.is_const_qualified()

    def _ref(self) -> Optional[Type]:
        match self.type.kind:
            case TypeKind.POINTER:  # ty:ignore[unresolved-attribute]
                return self.type.get_pointee()
            case TypeKind.INCOMPLETEARRAY:  # ty:ignore[unresolved-attribute]
                return self.type.get_array_element_type()
            case _:
                return None

    @cached_property
    def ref(self) -> Optional["TypeWrapper"]:
        if ref := self._ref():
            return TypeWrapper(arena=self.arena, type=ref)
        return None

    @cached_property
    def zig_type(self) -> str:
        match self.type.kind:
            case TypeKind.POINTER:  # ty:ignore[unresolved-attribute]
                if ref := self.ref:
                    if self.const:
                        return "*const " + ref.zig_type
                    else:
                        return "*" + ref.zig_type
            case TypeKind.ELABORATED:  # ty:ignore[unresolved-attribute]
                if clz := self.arena.typedef_index.get(self.name):
                    return clz.zig_name
                return self.name
            case TypeKind.CHAR_S:  # ty:ignore[unresolved-attribute]
                return "i8"
            case TypeKind.UCHAR:  # ty:ignore[unresolved-attribute]
                return "u8"
            case TypeKind.INT:  # ty:ignore[unresolved-attribute]
                return "i64"
            case TypeKind.UINT:  # ty:ignore[unresolved-attribute]
                return "u64"
            case TypeKind.INCOMPLETEARRAY:  # ty:ignore[unresolved-attribute]
                if ref := self.ref:
                    return "[*]" + ref.zig_type
            case TypeKind.DOUBLE:  # ty:ignore[unresolved-attribute]
                return "f64"
            case TypeKind.VOID:  # ty:ignore[unresolved-attribute]
                return "void"
            case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
                return "u6502"  # TODO
            case _:
                print(self.full_name)
                raise ValueError(self.type.kind.spelling)

        raise ValueError(f"Unsupported type: {self.full_name}")


@dataclass(kw_only=True, frozen=True)
class ArgWrapper(CursorWrapper):
    index: int

    @cached_property
    def name(self) -> str:
        return self.cursor.referenced.spelling or f"arg{self.index}"

    @cached_property
    def type(self) -> TypeWrapper:
        return TypeWrapper(arena=self.arena, type=self.cursor.type)


@dataclass(kw_only=True, frozen=True)
class FunctionProtoWrapper(CursorWrapper):
    @cached_property
    def return_type(self) -> TypeWrapper:
        return TypeWrapper(arena=self.arena, type=self.cursor.result_type)

    @cached_property
    def args(self) -> list[ArgWrapper]:
        return [
            ArgWrapper(arena=self.arena, cursor=cursor, index=i)
            for i, cursor in enumerate(self.cursor.get_arguments())
        ]

    @cached_property
    def constructs(self) -> Optional[TypedefWrapper]:
        """
        If this is a constructor the type of thing it constructs
        """
        if cons := self.return_type.ref:
            return self.arena.typedef_index.get(cons.name)
        return None

    @cached_property
    def method_of(self) -> Optional[TypedefWrapper]:
        """
        If this is a method typeof the thing it's a method of
        """
        if len(self.args) > 0:
            if this := self.args[0].type.ref:
                return self.arena.typedef_index.get(this.name)
        return None

    @cached_property
    def affinity(self) -> Optional[TypedefWrapper]:
        maybe = [clz for clz in (self.constructs, self.method_of) if clz]
        longest = sorted(maybe, key=lambda x: len(x.class_name), reverse=True)
        for clz in longest:
            if self.name.startswith(clz.class_name):
                return clz
        if maybe:
            return maybe[0]
        return None

    @cached_property
    def fn_name(self) -> str:
        name = self.name
        if clz := self.affinity:
            prefixes = [name for name in (clz.prefix, clz.class_name) if name]
            prefixes.sort(key=lambda name: len(name), reverse=True)
            for prefix in prefixes:
                if name.startswith(prefix):
                    return name[len(prefix) :]
        return name

    @cached_property
    def zig_name(self) -> str:
        return camel_case(self.fn_name)


@dataclass(kw_only=True, frozen=True)
class Arena:
    typedefs: list[TypedefWrapper] = field(default_factory=list)
    protos: list[FunctionProtoWrapper] = field(default_factory=list)

    def scan_source(self, cursor: Cursor) -> None:
        match cursor.type.kind:
            case TypeKind.TYPEDEF:  # ty:ignore[unresolved-attribute]
                decl = TypedefWrapper(
                    arena=self,
                    cursor=cursor,
                )
                self.typedefs.append(decl)
            case TypeKind.FUNCTIONPROTO:  # ty:ignore[unresolved-attribute]
                decl = FunctionProtoWrapper(
                    arena=self,
                    cursor=cursor,
                )
                self.protos.append(decl)
            case _:
                for child in cursor.get_children():
                    self.scan_source(child)

    @cached_property
    def typedef_index(self) -> dict[str, TypedefWrapper]:
        index: dict[str, TypedefWrapper] = {}
        for typedef in self.typedefs:
            index[typedef.name] = typedef
        return index

    @cached_property
    def proto_index(self) -> dict[str, FunctionProtoWrapper]:
        index: dict[str, FunctionProtoWrapper] = {}
        for proto in self.protos:
            index[proto.name] = proto
        return index

    @cached_property
    def method_index(self) -> dict[str, list[FunctionProtoWrapper]]:
        index: dict[str, list[FunctionProtoWrapper]] = {}
        for proto in self.proto_index.values():
            if clazz := proto.affinity:
                if clazz == proto.method_of:
                    index.setdefault(clazz.name, []).append(proto)
        return index

    @cached_property
    def constructor_index(self) -> dict[str, list[FunctionProtoWrapper]]:
        index: dict[str, list[FunctionProtoWrapper]] = {}
        for proto in self.proto_index.values():
            if clazz := proto.affinity:
                if clazz == proto.constructs:
                    index.setdefault(clazz.name, []).append(proto)
        return index

    @cached_property
    def free_functions(self) -> list[FunctionProtoWrapper]:
        free: list[FunctionProtoWrapper] = []
        for proto in self.proto_index.values():
            if proto.method_of or proto.constructs:
                continue
            free.append(proto)
        return free


def show_fn(fn: FunctionProtoWrapper) -> None:
    print(f"// {fn.name}")
    print(f"pub fn {fn.zig_name}(")
    for arg in fn.args:
        print(f"{arg.name}: {arg.type.zig_type}, ")
    print(f") {fn.return_type.zig_type} " + "{")
    for arg in fn.args:
        print(f"_ = {arg.name};")
    print("}")

    print()


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena()
    arena.scan_source(tu.cursor)
    for td in arena.typedef_index.values():
        print(f"// {td.name}")
        print(f"pub const {td.zig_name} = struct " + "{")
        if td.constructors:
            print("// constructors:")
            for cons in td.constructors:
                show_fn(cons)
        if td.methods:
            print("// methods:")
            for meth in td.methods:
                show_fn(meth)
        print("};\n")

    print("// Free functions:")
    for fn in arena.free_functions:
        show_fn(fn)


if __name__ == "__main__":
    main("../../rocksdb/include/rocksdb/c.h")
