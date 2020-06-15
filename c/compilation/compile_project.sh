#!/usr/bin/env bash
#
# Compile a local project in c
#
# Will find .h files, find the corresponding .c files and create .o files for linking
# Will also link these .o files and compile the entrypoint to a .out file
# Will confirm the creation of the .o and .out files, failing if not generated
#
# Example: sh compile_project.sh
#

ENTRYPOINT="main"

echo "$(date +%c): Searching for .h files to create corresponding .o files"
HEADER_FILES_ARRAY=()
SRC_FILES_ARRAY=()
OBJ_FILES_ARRAY=()
HEADER_FILES_STRING=($(find -E . -type f -regex "^.*\.h$"))
for HEADER_FILE in ${HEADER_FILES_STRING[*]}
do
  BASE_HEADER_FILE=${HEADER_FILE#"./"}
  BASE_SRC_FILE="${BASE_HEADER_FILE/\.h/.c}"
  BASE_OBJ_FILE="${BASE_HEADER_FILE/\.h/.o}"
  HEADER_FILES_ARRAY+=($BASE_HEADER_FILE)
  SRC_FILES_ARRAY+=($BASE_SRC_FILE)
  OBJ_FILES_ARRAY+=($BASE_OBJ_FILE)
done

echo "$(date +%c): Header Files = ${HEADER_FILES_ARRAY[*]}"
echo "$(date +%c): SRC Files = ${SRC_FILES_ARRAY[*]}"
echo "$(date +%c): Object Files = ${OBJ_FILES_ARRAY[*]}"

for SRC_FILE in "${SRC_FILES_ARRAY[@]}"
do
  echo "$(date +%c): Compiling .c files for found .h files: $SRC_FILE"
  clang $SRC_FILE -c
  OBJ_FILE="${SRC_FILE/\.c/.o}"
  if [ -f $OBJ_FILE ]
  then
    echo "$(date +%c): $OBJ_FILE generated successfully"
  else
    echo "$(date +%c): $OBJ_FILE failed to generate, exiting"
    exit 1
  fi
done

echo "$(date +%c): Compiling ${ENTRYPOINT}.c to ${ENTRYPOINT}.out"
echo "$(date +%c): Command = 'clang ${ENTRYPOINT}.c ${OBJ_FILES_ARRAY[*]} -std=c11 -o ${ENTRYPOINT}.out -ftrapv -Wall'"
clang ${ENTRYPOINT}.c ${OBJ_FILES_ARRAY[*]} -std=c11 -o ${ENTRYPOINT}.out -ftrapv -Wall

echo "$(date +%c): Checking for output file generation ${ENTRYPOINT}.out"
if [ -f "${ENTRYPOINT}.out" ]
then
  echo "$(date +%c): $ENTRYPOINT generated successfully"
else
  echo "$(date +%c): $ENTRYPOINT failed to generate executable, exiting"
  exit 1
fi
