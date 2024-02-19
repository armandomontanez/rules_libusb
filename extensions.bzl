load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _libusb_srcs_impl(_ctx):
    # TODO: Make this configurable so versioning is supported.
    http_archive(
        name = "libusb_srcs",
        urls = ["https://github.com/libusb/libusb/releases/download/v1.0.27/libusb-1.0.27.tar.bz2"],
        build_file = "libusb.BUILD",
        strip_prefix = "libusb-1.0.27",
        sha256 = "ffaa41d741a8a3bee244ac8e54a72ea05bf2879663c098c82fc5757853441575",
    )

libusb_srcs = module_extension(
    implementation = _libusb_srcs_impl,
)
