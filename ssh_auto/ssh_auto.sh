#!/bin/bash 
input="/home/iplist" 
while IFS= read -r var 
do 
ssh -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" <<'ENDSSH' 
cp -rpf /home/ec2-user/.ssh/authorized_keys /home/ec2-user/.ssh/authorized_keys-orig 
ENDSSH

mapfile < /root/.ssh/id_rsa.pub    
echo "${MAPFILE[@]}" | ssh -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$var" "cat >> /home/ec2-user/.ssh/authorized_keys"
done < "$input"
