#!/bin/bash

echo `aws ec2 describe-instances --region us-east-2 --filters "Name=tag:Name,Values=elk_server" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
echo `aws ec2 describe-instances --region us-east-2 --filters "Name=tag:Name,Values=elk_client" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
