const std = @import("std");
const foo = @cImport({
    @cInclude("foo.h");
});

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    std.log.info("foo = {d}", .{foo.fooFunc()});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
