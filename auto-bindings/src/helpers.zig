const std = @import("std");
const Io = std.Io;
const print = std.debug.print;
const assert = std.debug.assert;

/// Return the type that a wrapper wraps. A wrapper is defined as a packed or extern
/// struct with a single field that is a pointer to an underlying API object.
pub fn wrappedType(comptime T: type) type {
    assert(@sizeOf(T) == @sizeOf(*u8));
    const info = @typeInfo(T).@"struct";
    assert(info.layout == .@"packed" or info.layout == .@"extern");
    assert(info.fields.len == 1);
    return info.fields[0].type;
}

test wrappedType {
    comptime assert(wrappedType(packed struct { ref: *u32 }) == *u32);
}

/// Cast from a wrapper (a single field packed / extern struct) and the underlying
/// pointer.
pub fn unwrap(wrapper: anytype) wrappedType(@TypeOf(wrapper)) {
    comptime assert(@sizeOf(usize) == @sizeOf(*u8));
    return @ptrFromInt(@as(usize, @bitCast(wrapper)));
}

/// Cast from an API pointer to a corresponding wrapper
pub fn wrap(comptime T: type, value: wrappedType(T)) T {
    return @as(T, @bitCast(@intFromPtr(value)));
}

test {
    var root: u32 = 1;
    const handle: [*c]u32 = @ptrCast(&root);
    const wrapper = wrap(packed struct { ref: *u32 }, handle);

    comptime assert(@sizeOf(@TypeOf(wrapper)) == 8);

    try std.testing.expectEqual(handle, unwrap(wrapper));
}
