#!/bin/bash

PYTHON_VERSION="python3.6"
VENV_NAME="${PYTHON_VERSION}"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -P|-p|--python)
        PYTHON_VERSION="$2"
        shift
        shift
        ;;
        --python=*)
        PYTHON_VERSION="${1#*=}"
        shift # past argument=value
        ;;
        -N|-n|--name)
        VENV_NAME="$2"
        shift
        shift
        ;;
        --name=*)
        VENV_NAME="${1#*=}"
        shift # past argument=value
        ;;
        *)
        shift
        ;;
    esac
done

echo "$(date +%c): Building Virtual Environment ${PYTHON_VERSION} called ${VENV_NAME}"
VENV_COMMAND="${PYTHON_VERSION} -m virtualenv ${VENV_NAME}"
eval "${VENV_COMMAND}"
