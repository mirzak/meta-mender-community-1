require recipes-bsp/u-boot/u-boot-variscite-mender-common.inc
require recipes-bsp/u-boot/u-boot-fw-utils-mender.inc

do_compile_imx6ul-var-dart () {
    oe_runmake mx6ul_var_dart_mmc_defconfig
    oe_runmake env
}

do_install_imx6ul-var-dart () {
    install -d ${D}${base_sbindir}
    install -d ${D}${sysconfdir}
    install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s ${base_sbindir}/fw_printenv ${D}${base_sbindir}/fw_setenv
}
