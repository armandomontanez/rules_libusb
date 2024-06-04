# Copyright 2024 Armando Montanez
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

alias(
    name = "libusb",
    actual = "libusb-1.0",
    visibility = ["//visibility:public"],
)

cc_shared_library(
    name = "libusb-1.0",
    # Always use exactly this name.
    shared_lib_name = select({
        "@platforms//os:macos": "libusb-1.0.dylib",
        "@platforms//os:windows": "libusb-1.0.dll",
        "//conditions:default": "libusb-1.0.so",
    }),
    win_def_file = select({
        "@platforms//os:windows": "libusb/libusb-1.0.def",
        "//conditions:default": None,
    }),
    deps = [":libusb_core"],
    visibility = ["//visibility:public"],
)

label_flag(
    name = "libusb_config",
    build_setting_default = "@libusb//:default_libusb_config",
)

# To use this `config.h`, include it as `msvc/config.h` from your actual
# `config.h`.
cc_library(
    name = "libusb_msvc_config",
    hdrs = ["msvc/config.h"],
    visibility = ["//visibility:public"],
)

# To use this `config.h`, include it as `Xcode/config.h` from your actual
# `config.h`.
cc_library(
    name = "libusb_macos_config",
    hdrs = ["Xcode/config.h"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libusb_headers",
    hdrs = glob(["libusb/*.h"]),
    includes = ["libusb"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libusb_windows",
    srcs = glob(["libusb/os/*_windows.c"]),
    hdrs = glob(["libusb/os/*_windows.h"]),
    visibility = ["//visibility:private"],
    deps = [
        ":libusb_config",
        ":libusb_headers",
    ],
)

cc_library(
    name = "libusb_posix",
    srcs = glob(["libusb/os/*_posix.c"]),
    hdrs = glob(["libusb/os/*_posix.h"]),
    visibility = ["//visibility:private"],
    deps = [
        ":libusb_config",
        ":libusb_headers",
    ],
)

_GENERATED_UDEV_OR_NETLINK = """
#include "config.h"

#if HAVE_LIBUDEV
#include "libusb/os/linux_udev.c"
#else
#include "libusb/os/linux_netlink.c"
#endif  // HAVE_LIBUDEV
"""

genrule(
    name = "autodetect_udev",
    outs = ["udev_or_netlink.c"],
    cmd = "echo '{}' > $@".format(_GENERATED_UDEV_OR_NETLINK),
)

cc_library(
    name = "libusb_linux",
    srcs = glob(
        ["libusb/os/linux_*.c"],
        exclude = [
            "libusb/os/linux_netlink.c",
            "libusb/os/linux_udev.c",
        ],
    ) + [
        "udev_or_netlink.c",
    ],
    hdrs = glob(["libusb/os/linux_*.h"]) + [
        # These are listed as `hdrs` because they're selected by
        # an `#include` in the generated `udev_or_netlink.c`.
        "libusb/os/linux_netlink.c",
        "libusb/os/linux_udev.c",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":libusb_config",
        ":libusb_headers",
        ":libusb_posix",
    ],
)

cc_library(
    name = "libusb_macos",
    srcs = glob(["libusb/os/darwin_*.c"]),
    hdrs = glob(["libusb/os/darwin_*.h"]),
    linkopts = [
        "-framework IOKit",
        "-framework Security",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":libusb_config",
        ":libusb_headers",
        ":libusb_posix",
    ],
)

cc_library(
    name = "libusb_core",
    srcs = glob(["libusb/*.c"]),
    visibility = ["//visibility:private"],
    deps = select({
        "@platforms//os:linux": [":libusb_linux"],
        "@platforms//os:macos": [":libusb_macos"],
        "@platforms//os:windows": [":libusb_windows"],
        "//conditions:default": ["@platforms//:incompatible"],
    }) + [
        ":libusb_config",
        ":libusb_headers",
    ],
)
