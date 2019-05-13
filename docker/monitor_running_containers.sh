#!/usr/bin/env bash
#
# Monitor Running Containers in Clean Fashion
#
# Example: sh monitor_running_containers.sh
#

watch -d 'docker container ls --format "table {{.Image}}\t{{.Names}}\t{{.Ports}}\t{{.Command}}"'
