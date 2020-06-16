#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Get EC2 Instance metadata from inside a EC2 instance running an amazon linux AMI
#
# Arguments:
# -h [value], --help [value]
#    Get help and exit
#
# Example:
# bash get_instance_metadata_on_aws_ami_instance.sh
# -----------------------------------------------------------------------------


###
# Helper Functions and Setup
###


function log {
  echo "$(date +%c) $1: $2"
}


###
# Argument Parsing
###


# Create Variables, Set Defaults
# N/A

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
        log "INFO" "bash get_instance_metadata_on_aws_ami_instance.sh"
        exit 0
        ;;
        *)
        log "ERROR" "Invalid Argument: $1, exiting"
        exit 1
        ;;
    esac
done


###
# Argument Verification
###


# N/A


###
# Get Data
###


# Get the Hostname
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

# Get the Instance Type
INSTANCE_TYPE=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)

# Get the Region/Availability Zone
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
REGION=${AVAILABILITY_ZONE::-1}

# Get the Security Group
SECURITY_GROUPS=$(curl -s http://169.254.169.254/latest/meta-data/security-groups)


###
# Report Data
###


log "INFO" "HOSTNAME: ${HOSTNAME}"
log "INFO" "INSTANCE_TYPE: ${INSTANCE_TYPE}"
log "INFO" "AVAILABILITY_ZONE: ${AVAILABILITY_ZONE}"
log "INFO" "REGION: ${REGION}"
log "INFO" "SECURITY_GROUPS: ${SECURITY_GROUPS}"
