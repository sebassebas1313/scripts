#!/bin/bash

# replace staging for dyanmic ENV e.g. $AWS_DEPLOYMENT_ENVIRONMENT
ENV="staging"

# get subnets
sub_nets=$(aws ec2 describe-subnets --filters Name=tag:aws:cloudformation:logical-id,Values=PrivateSubnet? | jq -r ".Subnets[] | .VpcId")

# export variables of sub net
INDEX=1
for i in $sub_nets
  do
    echo SUBNET_${INDEX}=$i
    ((INDEX++))
  done

#insert validation for subnet

# replace for $APP_NAME
APP_NAME="cwithholding"

# get security group
security_group=$(aws ec2 describe-security-groups --filters Name=group-name,Values=*$ENV-$APP_NAME*Web* | jq .SecurityGroups[0].GroupId)

if [[ $security_group == "null" ]]; then
  echo "security group id not found"
  exit 1
fi

echo SECURITY_GROUP=$security_group
