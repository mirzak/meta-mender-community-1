inherit deploy

deploy_files_for_overlay() {
    install -d ${DEPLOYDIR}/dir-overlay
    cp -a ${PKGDEST}/${PN}/ ${DEPLOYDIR}/dir-overlay
}

# Provide default, empty do_deploy.
do_deploy() {
}
addtask do_deploy after do_package

# Add our own deploy steps.
do_deploy_append() {
    deploy_files_for_overlay
}
