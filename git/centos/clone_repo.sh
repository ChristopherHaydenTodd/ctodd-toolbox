#!/usr/bin/env bash
#
# Clone ChristopherHaydenTodd Git Repo With Correct Permissions
#
# Example Call:
#    ./clone_repo.sh {--repo_name="ctodd-python-lib-avro"}
#

REPOSITORY=""

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
        *)
        shift
        ;;
    esac
done

if [ -z "${REPOSITORY}" ]
then
  echo "$(date +%c): No Git Repository Specified, Exiting"
  exit 1
fi

echo "$(date +%c): Cloning ${REPOSITORY}"
git clone git@github-personal:ChristopherHaydenTodd/${REPOSITORY}.git;
cd ${REPOSITORY};
git config user.email "Christopher.Hayden.Todd@gmail.com";
git config user.name "Christopher H. Todd";
cd ..;

