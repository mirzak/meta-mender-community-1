# ------------------------------ CONFIGURATION ---------------------------------

# Extra arguments that should be passed to mender-artifact.
MENDER_ARTIFACT_EXTRA_ARGS ?= ""

# The key used to sign the mender update.
MENDER_ARTIFACT_SIGNING_KEY ?= ""

MENDER_DIR_OVERLAY_DEST_DIR ?= "/"

# --------------------------- END OF CONFIGURATION -----------------------------

do_image_mender_dir_overlay[depends] += "\
    mender-artifact-native:do_populate_sysroot \
    mender-dir-overlay-native:do_populate_sysroot \
"

OVERLAY_DIRECTORY = "${DEPLOY_DIR_IMAGE}/dir-overlay"

IMAGE_CMD_mender-dir-overlay () {
    set -x

    if [ -z "${MENDER_ARTIFACT_NAME}" ]; then
        bbfatal "Need to define MENDER_ARTIFACT_NAME variable."
    fi

    if [ -z "${MENDER_DEVICE_TYPES_COMPATIBLE}" ]; then
        bbfatal "MENDER_DEVICE_TYPES_COMPATIBLE variable cannot be empty."
    fi

    extra_args=

    for dev in ${MENDER_DEVICE_TYPES_COMPATIBLE}; do
        extra_args="$extra_args -t $dev"
    done

    if [ -n "${MENDER_ARTIFACT_SIGNING_KEY}" ]; then
        extra_args="$extra_args -k ${MENDER_ARTIFACT_SIGNING_KEY}"
    fi

    if mender-artifact write rootfs-image --help | grep -e '-u FILE'; then
        bbfatal "Minimum requirment is mender-artifact version 3.0.0"
    fi

    if [ -d "${OVERLAY_DIRECTORY}" ]; then
      tar -cf ${WORKDIR}/update.tar -C "${OVERLAY_DIRECTORY}" .
    else
      echo "Error: \"${OVERLAY_DIRECTORY}\" is not a directory or does not exit. Aborting."
      exit 1
    fi

    find ${OVERLAY_DIRECTORY} -type f | sed "s|^${OVERLAY_DIRECTORY}/||" > ${WORKDIR}/manifest

    echo "${MENDER_DIR_OVERLAY_DEST_DIR}" > ${WORKDIR}/dest_dir

    mender-artifact write module-image \
      -T dir-overlay \
      -n ${MENDER_ARTIFACT_NAME}-dir-overlay \
      ${MENDER_ARTIFACT_EXTRA_ARGS} \
      $extra_args \
      -f ${WORKDIR}/update.tar \
      -f ${WORKDIR}/dest_dir \
      -f ${WORKDIR}/manifest \
      -o ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.dir.overlay.mender

    ln -sfn "${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.dir.overlay.mender" \
            "${IMGDEPLOYDIR}/${IMAGE_BASENAME}-${MACHINE}.dir.overlay.mender"
}
