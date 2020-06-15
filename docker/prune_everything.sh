#!/usr/bin/env bash
#
# Prune Everything
#
# Example: sh prune_everything.sh
#

echo "$(date +%c): Pruning Containers (not running, over 24 hours)"
docker container prune --force --filter "until=24h";

echo "$(date +%c): Pruning Networks (not being used, over 24 hours)"
docker network prune --force --filter "until=24h";

echo "$(date +%c): Pruning Volumes (not being used, not marked keep)"
docker volume prune --force --filter "label!=keep";

echo "$(date +%c): Pruning Images (not being used, over 24 hours)"
docker image prune -a --force --filter "until=24h";
