#!/usr/bin/env bash
#
# Clean a local project in c
#
# Example: sh clean_project.sh
#

echo "$(date +%c): Removing .o Files"
rm -rf *.o

echo "$(date +%c): Removing .out Files"
rm -rf *.out
