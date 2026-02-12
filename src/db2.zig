const std = @import("std");
const assert = std.debug.assert;
const print = std.debug.print;

test {
    // const defs = @cImport({
    // @cDefine("_Nonnull", "");
    // @cInclude("rocksdb/c.h");
    // });
    const defs = @import("rocksdb");
    const info = @typeInfo(defs).@"struct";
    @setEvalBranchQuota(std.math.maxInt(u32));
    if (true) inline for (info.decls) |d| {
        if (std.mem.startsWith(u8, d.name, "rocksdb_")) {
            print("{s}\n", .{d.name});
            if (false) {
                const fun = @typeInfo(@TypeOf(@field(defs, d.name)));
                switch (fun) {
                    .@"fn" => print("fn {s}\n", .{d.name}),
                    else => {},
                }
            }
            // print("{any}\n", .{fun});
        }
    };

    if (false) {
        const meth = @typeInfo(@TypeOf(defs.rocksdb_options_set_error_if_exists)).@"fn";
        inline for (meth.params) |p| {
            print("{any}\n", .{p.type});
        }
    }
}
