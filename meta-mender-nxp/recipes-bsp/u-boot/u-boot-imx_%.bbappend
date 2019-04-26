FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

require recipes-bsp/u-boot/u-boot-mender.inc

BOOTENV_SIZE_imx8mqevk = "0x1000"

SRC_URI_remove = " \
    file://0003-Integration-of-Mender-boot-code-into-U-Boot.patch \
    file://0006-env-Kconfig-Add-descriptions-so-environment-options-.patch \
"

SRC_URI_append = " \
    file://default-gcc.patch \
    file://0002-ext4-cache-extent-blocks-during-file-reads.patch \
"

SRC_URI_append_imx8mqevk = "file://0001-imx8mq_evk-Mender-integration.patch"

MENDER_UBOOT_AUTO_CONFIGURE = "0"
