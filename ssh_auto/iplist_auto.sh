#!/bin/bash

echo `aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=tests" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
echo `aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=testc" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
