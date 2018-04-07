#!/bin/bash 
cd /home/ec2-user
cp -rpf /home/ec2-user/.ssh/authorized_keys /home/ec2-user/.ssh/authorized_keys-orig

mapfile < /home/ec2-user/id_rsa.pub
echo "${MAPFILE[@]}" | cat >> /home/ec2-user/.ssh/authorized_keys

rm -rf *
