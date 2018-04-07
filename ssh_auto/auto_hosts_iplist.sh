#!/bin/bash 

>iplist
>../hosts
#apt-get install python3-pip -y
#pip3 install --upgrade awscli

#aws ec2 run-instances --iam-instance-profile Name=Admin_Role --image-id ami-26ebbc5c --count 1 --instance-type t2.medium --key-name IOT-Pavan-Keypair --security-group-ids sg-99e802e5 --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=35} --count 1 --subnet-id subnet-a4ff9dff --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tests}]' 'ResourceType=volume,Tags=[{Key=Name,Value=tests}]'

#aws ec2 run-instances --iam-instance-profile Name=Admin_Role --image-id ami-26ebbc5c --count 1 --instance-type t2.medium --key-name IOT-Pavan-Keypair --security-group-ids sg-99e802e5 --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=35} --count 1 --subnet-id subnet-a4ff9dff --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=testc}]' 'ResourceType=volume,Tags=[{Key=Name,Value=testc}]'

#sleep 200

cp -rpf /home/IOT-Pavan-Keypair.pem .

sh hosts_auto.sh
sh iplist_auto.sh
rm -rf IOT-Pavan-Keypair.pem
