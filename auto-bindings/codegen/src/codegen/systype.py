"""A simple representation of C/C++/Zig types for code generation"""

from dataclasses import dataclass
from enum import Enum
from typing import Optional


@dataclass(kw_only=True)
class BaseType:
    is_const: bool


@dataclass(kw_only=True)
class VoidType:
    is_const: bool


@dataclass(kw_only=True)
class IntType(BaseType):
    signed: bool
    bits: int


@dataclass(kw_only=True)
class FloatType(BaseType):
    bits: int


class PointerSize(Enum):
    ONE = 1
    MANY = 2
    SLICE = 3
    C = 4


@dataclass(kw_only=True)
class ArrayType(BaseType):
    child: "SysType"
    sentinel: Optional[int] = None


@dataclass(kw_only=True)
class PointerType(BaseType):
    child: "SysType"
    size: PointerSize = PointerSize.C
    sentinel: Optional[int] = None


@dataclass(kw_only=True)
class ExtType(BaseType):
    name: str
    namespace: Optional[str] = None


@dataclass(kw_only=True)
class FnType(BaseType):
    arg_types: list["SysType"]
    ret_type: "SysType"


type SysType = (
    VoidType | IntType | FloatType | PointerType | ArrayType | ExtType | FnType
)
