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
