const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("build-zig", "src/main.zig");
    exe.addIncludeDir("src");
    exe.addCSourceFiles(&.{"src/foo.c" },
     &.{
        "-std=c99",
        "-Wall",
        "-DLUA_ANSI",
        "-DENABLE_CJSON_GLOBAL",
        "-DLUA_USE_MKSTEMP",
    });
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
