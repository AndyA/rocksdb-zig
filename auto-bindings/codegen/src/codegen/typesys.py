"""A simple representation of C/C++/Zig types for code generation"""

from dataclasses import dataclass


@dataclass(kw_only=True, frozen=True)
class BaseType:
    is_const: bool


@dataclass(kw_only=True, frozen=True)
class VoidType:
    is_const: bool


@dataclass(kw_only=True, frozen=True)
class IntType(BaseType):
    signed: bool
    bits: int


@dataclass(kw_only=True, frozen=True)
class FloatType(BaseType):
    bits: int


@dataclass(kw_only=True, frozen=True)
class PointerType(BaseType):
    ref_type: "SysType"


@dataclass(kw_only=True, frozen=True)
class ArrayType(BaseType):
    child_type: "SysType"


@dataclass(kw_only=True, frozen=True)
class ExtType(BaseType):
    name: str


@dataclass(kw_only=True, frozen=True)
class FnType(BaseType):
    arg_types: list["SysType"]
    ret_type: "SysType"


type SysType = (
    VoidType | IntType | FloatType | PointerType | ArrayType | ExtType | FnType
)
