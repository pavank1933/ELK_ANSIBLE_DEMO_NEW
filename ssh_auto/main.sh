#!/bin/bash 

>iplist
>../hosts
apt-get install python3-pip -y
pip3 install --upgrade awscli

aws ec2 run-instances --iam-instance-profile Name=Admin_Role --image-id ami-26ebbc5c --count 1 --instance-type t2.medium --key-name IOT-Pavan-Keypair --security-group-ids sg-99e802e5 --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=35} --count 1 --subnet-id subnet-a4ff9dff --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tests}]' 'ResourceType=volume,Tags=[{Key=Name,Value=tests}]'

aws ec2 run-instances --iam-instance-profile Name=Admin_Role --image-id ami-26ebbc5c --count 1 --instance-type t2.medium --key-name IOT-Pavan-Keypair --security-group-ids sg-99e802e5 --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=35} --count 1 --subnet-id subnet-a4ff9dff --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=testc}]' 'ResourceType=volume,Tags=[{Key=Name,Value=testc}]'

sleep 200

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

cd ..

rm -rf install/elk.retry 
rm -rf install/elk-client.retry

ansible-playbook -i hosts install/elk.yml 


#bash ssh_auto/spring_auto_boot.sh

client=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=tests" --query "Reservations[*].Instances[*].PrivateIpAddress" --output=text`

ansible-playbook -i hosts install/elk-client.yml --extra-vars 'elk_server="'"$client"'"'


#cp -rpf /home/IOT-Pavan-Keypair.pem .

bash ssh_auto/spring_auto_boot.sh


server=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=testc" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text`

ssh -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$server" <<'ENDSSH' 
sudo su
yum install lsof -y
cd /home/ec2-user/spring*
#kill -9 $(lsof -t -i:8080)
source /etc/profile.d/maven.sh
mvn spring-boot:run
ENDSSH

rm -rf IOT-Pavan-Keypair.pem
