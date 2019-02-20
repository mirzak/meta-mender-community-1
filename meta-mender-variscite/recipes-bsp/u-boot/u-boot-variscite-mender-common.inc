FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

MENDER_UBOOT_AUTO_CONFIGURE = "0"

BOOTENV_SIZE_imx6ul-var-dart = "0x00002000"

SRC_URI_append_imx6ul-var-dart = " file://0001-CONFIGS-mx6_ul_var_dart-add-Mender-support.patch"

SRC_URI_remove = "file://0006-env-Kconfig-Add-descriptions-so-environment-options-.patch"
