#!/usr/bin/env bash
#
# Push Docker Image To Repository
#
# Example: sh push_docker_image_to_repo.sh --image="some_image" --version="1.0.1" \
#     --repo=https://localhost:22222
#

REPOSITORY=""
IMAGE_NAME=""
IMAGE_VERSION="latest"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -R|-r|--repo)
        REPOSITORY="$2"
        shift
        shift
        ;;
        --repo=*)
        REPOSITORY="${1#*=}"
        shift
        ;;
        -N|-n|--name)
        IMAGE_NAME="$2"
        shift
        shift
        ;;
        --name=*)
        IMAGE_NAME="${1#*=}"
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
        *)
        shift
        ;;
    esac
done

if [ -z "${REPOSITORY}" ]
then
  echo "$(date +%c): No Repository Specified (--repo=name), Exiting"
  exit 1
fi

if [ -z "${IMAGE_NAME}" ]
then
  echo "$(date +%c): No Image Name Specified (--image=name), Exiting"
  exit 1
fi

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

echo "$(date +%c): Pushing ${IMAGE} to ${REPOSITORY}"
docker tag ${IMAGE} ${REPOSITORY}/${IMAGE}
docker push ${REPOSITORY}/${IMAGE}
