#!/bin/bash

# Get all the S3 object keys, excluding folders.
declare -a arr=($(aws s3api list-objects-v2 --profile production --bucket dcs-s3-access-log-585721704734-eu-west-1 --prefix 585721704734-sigu-production-storage-585721704734-eu-west-12021-08 --query 'Contents[?LastModified >= `2021-08-08` && LastModified <= `2021-08-11`].[Key]' --output text))

echo $keys
echo "Copy to local"

## now loop through the above array | in the last part double $i, the first represent key of file to download and second represent the name of the file where the file will be downloaded·
for i in "${arr[@]}"
do
  echo $(aws s3api get-object --profile production --bucket dcs-s3-access-log-585721704734-eu-west-1 --key "$i" "$i")
done

: '
# Get objects.
foreach ($key in $KEYS) {
  echo $(aws s3api get-object --bucket dcs-s3-access-log-585721704734-eu-west-1--key ${key} ${key})
}
'
