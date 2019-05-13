#!/bin/bash

if [[ "$VIRTUAL_ENV" != "" ]]
then
  PYTHON_VERSION=$(which python)
  echo "Python Virtual Environment (${VIRTUAL_ENV} ${PYTHON_VERSION}) is Active"
else
  echo "Python Virtual Environment is NOT Active"
fi
