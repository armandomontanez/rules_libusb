load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_KNOWN_RELEASE_HASHES = {
    "v1.0.27": "ffaa41d741a8a3bee244ac8e54a72ea05bf2879663c098c82fc5757853441575",
    "v1.0.26": "12ce7a61fc9854d1d2a1ffe095f7b5fac19ddba095c259e6067a46500381b5a5",
}

def _libusb_impl(module_ctx):
    """ Fetches libusb sources as requested by Bazel modules.

    Intended behavior:
        - If the root module specifies a libusb release version, that is used.
        - If the libusb release version comes from a module dependency,
          the requested version is used IF AND ONLY IF there is a single, common
          version requested. If any modules request conflicting versions, an
          error is emitted.
    """
    root_module = True
    requested_versions = {}
    for module in module_ctx.modules:
        if len(module.tags.source_release) > 1:
            fail("`libusb.source_release()` specified multiple times in ", module.name)
        for release in module.tags.source_release:
            ver = release.version
            if ver:
                if ver not in requested_versions:
                    requested_versions[ver] = []
                requested_versions[ver].append(module.name)

        # The first module is always the root. If it specified a version, use
        # that and don't keep looking.
        if root_module:
            if requested_versions:
                break
            root_module = False

    if len(requested_versions.keys()) > 1:
        fail("Multiple modules have requested conflicting versions of libusb, please reconcile this by manually selecting a version in your project. The conflicting modules are: ", str(requested_versions))
    elif not requested_versions:
        fail("`libusb.source_release()` is not specified by any module")

    version_to_fetch = requested_versions.keys()[0]

    archive_stem = None
    if version_to_fetch.startswith("v"):
        archive_stem = "libusb-{}".format(version_to_fetch.lstrip('v'))
    if not archive_stem:
        fail("Unknown tag format; copy the tag directly from the libusb release URL")

    http_archive(
        name = "libusb_sources",
        urls = ["https://github.com/libusb/libusb/releases/download/{}/{}.tar.bz2".format(version_to_fetch, archive_stem)],
        build_file = "@libusb//:libusb.BUILD",
        strip_prefix = archive_stem,
        sha256 = _KNOWN_RELEASE_HASHES.get(version_to_fetch),
    )


libusb = module_extension(
    doc = "Bzlmod extension for pulling in libusb sources.",
    implementation = _libusb_impl,
    tag_classes = {
        "source_release": tag_class(
            doc = "Selects the source code version to use when building libusb.",
            attrs = {
                "version": attr.string(
                    mandatory = True,
                    doc = "Release tag for libusb source tarbal to use.",
                ),
            }
        ),
    }
)
