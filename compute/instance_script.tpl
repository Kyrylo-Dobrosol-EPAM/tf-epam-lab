#!/bin/bash
echo "bucket_name = ${bucket_name}"

EC2_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid |tr '[:upper:]' '[:lower:]')

TOKEN=$(curl --request PUT "http://169.254.169.254/latest/api/token" --header "X-aws-ec2-metadata-token-ttl-seconds: 3600")
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id --header "X-aws-ec2-metadata-token: $TOKEN")

echo "This message was generated on instance $INSTANCE_ID with the following UUID $EC2_MACHINE_UUID" | aws s3 cp - s3://${bucket_name}/$INSTANCE_ID.txt