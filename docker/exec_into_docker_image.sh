#!/usr/bin/env bash
#
# Exec Into Image By Container or Image ID
#
# Example: sh exec_into_docker_image.sh --image="some_image:1.0.1" --shell="/bin/sh"
#

CONTAINER_ID=""
IMAGE=""
SHELL="/bin/bash"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -C|-c|--container)
        CONTAINER_ID="$2"
        shift
        shift
        ;;
        --container=*)
        CONTAINER_ID="${1#*=}"
        shift
        ;;
        -I|-i|--image)
        IMAGE="$2"
        shift
        shift
        ;;
        --image=*)
        IMAGE="${1#*=}"
        shift
        ;;
        -S|-s|--shell)
        SHELL="$2"
        shift
        shift
        ;;
        --shell=*)
        SHELL="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${IMAGE}" ] && [ -z "${CONTAINER_ID}" ]
then
  echo "$(date +%c): No Image or Container Specified (--image=x or --container=x), Exiting"
  exit 1
fi

if [ -z "${CONTAINER_ID}" ]
then
  echo "$(date +%c): No Container Specified, Need to Fetch from Image (${IMAGE})"
  CONTAINER_ID=$(docker ps -qf ancestor=${IMAGE})
fi

if [ -z "${CONTAINER_ID}" ]
then
  echo "$(date +%c): Could not find running container of Image (${IMAGE}), Exiting"
  exit 1
fi

echo "$(date +%c): Execing into Container (${SHELL}) ${CONTAINER_ID} of image ${IMAGE}"
docker exec -it ${CONTAINER_ID} ${SHELL}
