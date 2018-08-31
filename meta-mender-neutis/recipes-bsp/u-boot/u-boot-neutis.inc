FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"
MENDER_UBOOT_AUTO_CONFIGURE = "0"

SRC_URI_append += " \
            file://0101-configs-enable-mender-things-for-Emlid-Neutis-N5.patch \
            file://0102-neutis-bsp-u-boot-patches-relax-U-Boot-size-limits.patch \
            "
