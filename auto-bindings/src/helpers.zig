const std = @import("std");
const Io = std.Io;
const print = std.debug.print;
const assert = std.debug.assert;

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

pub fn unwrap(wrapper: anytype) wrappedType(@TypeOf(wrapper)) {
    comptime assert(@sizeOf(usize) == @sizeOf(*u8));
    return @ptrFromInt(@as(usize, @bitCast(wrapper)));
}

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
