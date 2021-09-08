#!/bin/bash

# Get all the S3 object keys, excluding folders.
$keys=($(aws s3api list-objects-v2 --bucket dcs-s3-access-log-585721704734-eu-west-1 --prefix 585721704734-sigu-production-storage-585721704734-eu-west-12021-08-08 --query "Contents[?(LastModified>='2021-08-08T00:00:00.00Z' && LastModified<='2021-08-11T00:00:00.00Z')].Key"  --output text))

echo "Copy to local"

# Get objects.
foreach ($key in $keys) {
		echo $(aws s3api get-object --bucket dcs-s3-access-log-585721704734-eu-west-1--key ${key} ${key})
}
