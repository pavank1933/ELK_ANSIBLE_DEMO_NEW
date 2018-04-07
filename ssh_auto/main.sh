#!/bin/bash 

cp -rpf /home/IOT-Pavan-Keypair.pem .

sh hosts_auto.sh
sh iplist_auto.sh

input="iplist"
while IFS= read -r var 
do
cp -rpf /root/.ssh/id_rsa.pub .
rsync -rave "ssh -o StrictHostKeyChecking=no -i IOT-Pavan-Keypair.pem" * ec2-user@"$var":/home/ec2-user
ssh -n -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" "chmod a+x /home/ec2-user/ssh_auto.sh"
ssh -n -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" '/home/ec2-user/ssh_auto.sh'
done < "$input"

rm -rf id_rsa.pub IOT-Pavan-Keypair.pem


sh spring_auto_boot.sh

cd ..
ansible-playbook -i hosts install/elk.yml 




client=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=testc" --query "Reservations[*].Instances[*].PrivateIpAddress" --output=text`
ansible-playbook -i hosts install/elk-client.yml --extra-vars 'elk_server=$client'

