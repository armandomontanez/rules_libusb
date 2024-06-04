# rules_libusb
A small wrapper Bazel module that builds libusb from sources. Supports Windows,
macOS, and Linux.

## Getting Started
At this time, rules_libusb only supports bzlmod projects. Legacy `WORKSPACE`
projects are not explicitly supported.

### blzmod
Add rules_libusb to your `MODULE.bazel` file:
```
bazel_dep(name = "rules_libusb", repo_name="libusb", version="0.1.0-rc1")
```

Then add `@libusb//:libusb` in `dynamic_deps` to the tool that uses it:
```
cc_binary(
    name = "my_tool",
    srcs = ["main.cpp"],
    dynamic_deps = ["@libusb//:libusb"],
)
```

If you have explicit libusb versioning requirements, you may add them to your
`MODULE.bazel`:
```
libusb = use_extension("@libusb//:extensions.bzl", "libusb")
libusb.source_release(min_version = "1.0.27")
```

Note: source_release constraints this follow bzlmod behavior of minimal version
selection.

## Building this repo
To build this repo, run:
```
bazel build //:libusb
```
