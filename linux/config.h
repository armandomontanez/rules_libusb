#define DEFAULT_VISIBILITY __attribute__ ((visibility ("default")))
#define ENABLE_LOGGING 1
#define HAVE_ASM_TYPES_H 1
#define HAVE_CLOCK_GETTIME 1
#define HAVE_DECL_EFD_CLOEXEC 1
#define HAVE_DECL_EFD_NONBLOCK 1
#define HAVE_DECL_TFD_CLOEXEC 1
#define HAVE_DECL_TFD_NONBLOCK 1
#define HAVE_DLFCN_H 1
#define HAVE_EVENTFD 1
#define HAVE_INTTYPES_H 1
#define HAVE_NFDS_T 1
#define HAVE_PIPE2 1
#define HAVE_PTHREAD_CONDATTR_SETCLOCK 1
#define HAVE_PTHREAD_SETNAME_NP 1
#define HAVE_STDINT_H 1
#define HAVE_STDIO_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_TIMERFD 1
#define HAVE_UNISTD_H 1

#define PLATFORM_POSIX 1

#define PRINTF_FORMAT(a, b) __attribute__ ((__format__ (__printf__, a, b)))
#define STDC_HEADERS 1

#define _GNU_SOURCE 1

// Explicitly define HAVE_LIBUDEV to prevent auto-detection.
#ifndef HAVE_LIBUDEV
#if __has_include(<libudev.h>)
#define HAVE_LIBUDEV 1
#endif  // __has_include(<libudev.h>)
#endif  // HAVE_LIBUDEV
