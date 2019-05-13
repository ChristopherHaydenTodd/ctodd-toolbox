#!/usr/bin/env bash
#
# Run Docker Image Locally (using the command)
#
#
# Example: sh push_docker_image_to_repo.sh --image="some_image" --version="1.0.1" \
#     --repo=https://localhost:22222 --command="/bin/bash"
#

CONTAINER_NAME=""
IMAGE_NAME=""
IMAGE_VERSION="latest"
COMMAND=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -N|-n|-name)
        CONTAINER_NAME="$2"
        shift
        shift
        ;;
        --name=*)
        CONTAINER_NAME="${1#*=}"
        shift
        ;;
        -C|--container)
        CONTAINER_NAME="$2"
        shift
        shift
        ;;
        --container=*)
        CONTAINER_NAME="${1#*=}"
        shift
        ;;
        -I|-i|--image)
        IMAGE_NAME="$2"
        shift
        shift
        ;;
        --image=*)
        IMAGE_NAME="${1#*=}"
        shift
        ;;
        -V|-v|--version)
        IMAGE_VERSION="$2"
        shift
        shift
        ;;
        --version=*)
        IMAGE_VERSION="${1#*=}"
        shift
        ;;
        -c|--command)
        COMMAND="$2"
        shift
        shift
        ;;
        --command=*)
        COMMAND="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${IMAGE_NAME}" ]
then
    echo "$(date +%c): No Image Name Specified (--image=name), Exiting"
    exit 1
fi

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

if [ -z "${CONTAINER_NAME}" ]
then
    CONTAINER_NAME=${IMAGE}
fi

if [ -z "${COMMAND}" ]
then
    echo "$(date +%c): Running Container ${CONTAINER_NAME} of image ${IMAGE} With Default Command"
    docker run --rm --detach --name=${CONTAINER_NAME} ${IMAGE}
else
    echo "$(date +%c): Running Container ${CONTAINER_NAME} of image ${IMAGE} With Command ${COMMAND}"
    docker run --rm --detach --name=${CONTAINER_NAME} ${IMAGE} ${COMMAND}
fi
