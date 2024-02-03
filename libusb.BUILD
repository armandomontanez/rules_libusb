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
    deps = [":libusb_core"],
    win_def_file = select({
        "@platforms//os:windows": "libusb/libusb-1.0.def",
        "//conditions:default": None,
    }),
)

label_flag(
    name = "libusb_config",
    build_setting_default = ":libusb_config_not_set",
)

# If you get the following error:
#
#   Target //:libusb is incompatible and cannot be built, but was explicitly requested.
#
# It's because you didn't set libusb_config. Add this to your .bazelrc:
#
#   --@libusb_srcs//:libusb_config=//:default_libusb_config
cc_library(
    name = "libusb_config_not_set",
    target_compatible_with = ["@platforms//:incompatible"],
    visibility = ["//visibility:private"],
)

# To use this `config.h`, include it as `msvc/config.h` from your actual
# `config.h`.
cc_library(
    name = "libusb_msvc_config",
    hdrs = ["msvc/config.h"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libusb_headers",
    includes = ["libusb"],
    hdrs = [
        "libusb/libusb.h",
        "libusb/libusbi.h",
        "libusb/version.h",
        "libusb/version_nano.h",
    ],
    visibility = ["//visibility:private"],
)

cc_library(
    name = "libusb_windows",
    hdrs = [
        "libusb/os/events_windows.h",
        "libusb/os/threads_windows.h",
        "libusb/os/windows_common.h",
        "libusb/os/windows_usbdk.h",
        "libusb/os/windows_winusb.h",
    ],
    srcs = [
        "libusb/os/events_windows.c",
        "libusb/os/threads_windows.c",
        "libusb/os/windows_common.c",
        "libusb/os/windows_usbdk.c",
        "libusb/os/windows_winusb.c",
    ],
    deps = [
        ":libusb_config",
        ":libusb_headers",
    ],
    visibility = ["//visibility:private"],
)

cc_library(
    name = "libusb_core",
    srcs = [
        "libusb/core.c",
        "libusb/descriptor.c",
        "libusb/hotplug.c",
        "libusb/io.c",
        "libusb/strerror.c",
        "libusb/sync.c",
    ],
    deps = select({
        "@platforms//os:linux": [":libusb_linux"],
        "@platforms//os:macos": [":libusb_macos"],
        "@platforms//os:windows": [":libusb_windows"],
        "//conditions:default": ["@platforms//:incompatible"],
    }) + [
        ":libusb_config",
        ":libusb_headers",
    ],
    visibility = ["//visibility:private"],
)
