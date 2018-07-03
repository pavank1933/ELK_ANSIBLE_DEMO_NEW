#!/bin/bash

aws_region="us-east-2"

echo "[elk]" >>../hosts

elk=`aws ec2 describe-instances --region $aws_region --filters "Name=tag:Name,Values=elk_server" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text`

echo "$elk ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/.ssh/id_rsa" >> ../hosts


echo "[elk-client]" >> ../hosts

elk_client=`aws ec2 describe-instances --region $aws_region --filters "Name=tag:Name,Values=elk_client" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text`

echo "$elk_client ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/.ssh/id_rsa" >> ../hosts
