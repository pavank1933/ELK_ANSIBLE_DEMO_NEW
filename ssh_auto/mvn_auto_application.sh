#!/bin/bash
cp -rpf /home/IOT-Pavan-Keypair.pem .
aws ec2 describe-instances --instance-ids  --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text >taglist
input="taglist"
while IFS= read -r var 
do
if [[ "$var" == elk-client* ]]; then
 
ssh -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" <<'ENDSSH' 
sudo su
yum install lsof -y
cd /home/ec2-user/spring*
#kill -9 $(lsof -t -i:8080)
source /etc/profile.d/maven.sh
mvn spring-boot:run
ENDSSH
fi
done < "$input"
rm -rf IOT-Pavan-Keypair.pem
rm -rf taglist
