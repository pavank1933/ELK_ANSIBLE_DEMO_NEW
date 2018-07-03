#!/bin/bash

aws_region="us-east-2"

echo `aws ec2 describe-instances --region $aws_region --filters "Name=tag:Name,Values=elk_server" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
echo `aws ec2 describe-instances --region $aws_region --filters "Name=tag:Name,Values=elk_client" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
