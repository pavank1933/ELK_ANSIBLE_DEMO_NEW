#!/bin/bash 
input="iplist"
while IFS= read -r var 
do
cp -rpf /root/.ssh/id_rsa.pub .
rsync -rave "ssh -o StrictHostKeyChecking=no -i IOT-Pavan-Keypair.pem" * ec2-user@"$var":/home/ec2-user
ssh -n -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" "chmod a+x /home/ec2-user/ssh_auto.sh"
ssh -n -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" '/home/ec2-user/ssh_auto.sh'
done < "$input"

rm -rf id_rsa.pub
