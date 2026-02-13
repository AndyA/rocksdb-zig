import re
from dataclasses import dataclass, field
from functools import cached_property
from typing import Optional

from clang.cindex import Cursor, Index, Type, TypeKind

HEADER = "../../rocksdb/include/rocksdb/c.h"


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
        return self.arena.constructor_index.get(self.name, [])

    @cached_property
    def methods(self) -> list["FunctionProtoWrapper"]:
        return self.arena.method_index.get(self.name, [])

    @cached_property
    def prefix(self) -> str:
        assert self.name.endswith("_t")
        return self.name[:-1]


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
        return self.type.is_const_qualified()

    @cached_property
    def ref(self) -> Optional["TypeWrapper"]:
        if self.type.kind == TypeKind.POINTER:
            return TypeWrapper(
                arena=self.arena,
                type=self.type.get_pointee(),
            )
        return None


@dataclass(kw_only=True, frozen=True)
class ArgWrapper(CursorWrapper):
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
            ArgWrapper(arena=self.arena, cursor=cursor)
            for cursor in self.cursor.get_arguments()
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
        longest = sorted(maybe, key=lambda x: len(x.prefix), reverse=True)
        for clz in longest:
            if self.name.startswith(clz.prefix):
                return clz
        if maybe:
            return maybe[0]
        return None

    @cached_property
    def fn_name(self) -> str:
        name = self.name
        if clz := self.affinity:
            if name.startswith(clz.prefix):
                return name[len(clz.prefix) :]
        return name


@dataclass(kw_only=True, frozen=True)
class Arena:
    typedefs: list[TypedefWrapper] = field(default_factory=list)
    protos: list[FunctionProtoWrapper] = field(default_factory=list)

    def scan_source(self, cursor: Cursor) -> None:
        match cursor.type.kind:
            case TypeKind.TYPEDEF:
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
        for proto in self.protos:
            if clazz := proto.affinity:
                if clazz == proto.method_of:
                    index.setdefault(clazz.name, []).append(proto)
        return index

    @cached_property
    def constructor_index(self) -> dict[str, list[FunctionProtoWrapper]]:
        index: dict[str, list[FunctionProtoWrapper]] = {}
        for proto in self.protos:
            if clazz := proto.affinity:
                if clazz == proto.constructs:
                    index.setdefault(clazz.name, []).append(proto)
        return index

    @cached_property
    def free_functions(self) -> list[FunctionProtoWrapper]:
        free: list[FunctionProtoWrapper] = []
        for proto in self.protos:
            if proto.method_of or proto.constructs:
                continue
            free.append(proto)
        return free


def main(header: str) -> None:
    idx = Index.create()
    tu = idx.parse(header)
    arena = Arena()
    arena.scan_source(tu.cursor)
    for td in arena.typedefs:
        print(f"class: {td.name}")
        print("  constructors:")
        for cons in td.constructors:
            print(f"    {cons.fn_name}")
        print("  methods:")
        for meth in td.methods:
            print(f"    {meth.fn_name}")

    print("Free functions:")
    for fn in arena.free_functions:
        print(f"  {fn.name}")


if __name__ == "__main__":
    main(HEADER)
