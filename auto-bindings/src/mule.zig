const std = @import("std");
const Io = std.Io;
const print = std.debug.print;

pub fn main(_: std.process.Init) !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

test {
    var root: u32 = 1;
    const handle: [*c]u32 = @ptrCast(&root);
    const wrapper: packed struct { ref: *u32 } = @bitCast(@intFromPtr(handle));

    try std.testing.expectEqual(handle, @as([*c]u32, @ptrFromInt(@as(usize, @bitCast(wrapper)))));
}
