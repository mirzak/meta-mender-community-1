require recipes-bsp/u-boot/u-boot-variscite-mender-common.inc
require recipes-bsp/u-boot/u-boot-mender.inc

UBOOT_VAR_BINARY = "u-boot-spl.img"
UBOOT_IMAGE_VAR ?= "u-boot-var-${MACHINE}-${PV}-${PR}.${UBOOT_SUFFIX}"
UBOOT_SYMLINK_VAR ?= "u-boot-var-${MACHINE}.${UBOOT_SUFFIX}"

do_compile_append_imx6ul-var-dart() {
    # This should be written to block '1' after MBR
    dd if=${B}/${SPL_BINARY} of=${B}/${UBOOT_VAR_BINARY} bs=1024
    dd if=${B}/${UBOOT_BINARY} of=${B}/${UBOOT_VAR_BINARY} seek=69 bs=1024
}

do_deploy_append_imx6ul-var-dart() {
    install -m 644 ${B}/${UBOOT_VAR_BINARY} ${DEPLOYDIR}/${UBOOT_IMAGE_VAR}

    cd ${DEPLOYDIR}
    rm -f ${UBOOT_VAR_BINARY} ${UBOOT_SYMLINK_VAR}
    ln -sf ${UBOOT_IMAGE_VAR} ${UBOOT_SYMLINK_VAR}
    ln -sf ${UBOOT_IMAGE_VAR} ${UBOOT_VAR_BINARY}
}
