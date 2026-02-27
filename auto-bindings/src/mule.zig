const std = @import("std");
// const Io = std.Io;
// const print = std.debug.print;
// const assert = std.debug.assert;

pub fn main(_: std.process.Init) !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

test {
    _ = @import("./helpers.zig");
}
