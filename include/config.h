// Copyright 2024 Armando Montanez
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if defined(_WIN32) | defined(_WIN64)

#if defined(_MSC_VER)
#include "msvc/config.h"
#endif // defined(_MSC_VER )

// TODO: MinGW-W64 and clang suppport.

#define _RULES_LIBUSB_OS_SUPPORTED

#elif defined(__linux__)

#include "linux/config.h"

#define _RULES_LIBUSB_OS_SUPPORTED

#endif  // defined(_WIN32) | defined(_WIN64)

// TODO: macOS support.

#if !defined(_RULES_LIBUSB_OS_SUPPORTED)
#error Unsupported configuration, either contribute to rules_libusb, or build your own `config.h`.
#endif  // !defined(_RULES_LIBUSB_OS_SUPPORTED)
