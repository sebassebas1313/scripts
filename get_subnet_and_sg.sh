#!/bin/bash

instance=$(aws ec2 describe-instances --filters Name=tag:Name,Values=$APP_NAME-$BITBUCKET_DEPLOYMENT_ENVIRONMENT-web | jq .Reservations[0].Instances[0])

export SUBNET=$( jq .SubnetId <<< "${instance}" )
export SG=$( jq -c '.SecurityGroups[] | select(.GroupName | contains("Web")) | .GroupId' <<< "${instance}" )
