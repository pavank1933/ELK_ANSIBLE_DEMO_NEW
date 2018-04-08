#!/bin/bash
#hosts_auto done

echo "[elk]" >>../hosts

elk=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=elk" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text`
echo "$elk ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/.ssh/id_rsa" >> ../hosts

echo `aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=elk" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist

aws ec2 describe-instances --instance-ids  --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text >taglist
input="taglist"
while IFS= read -r var 
do
if [[ "$var" == elk-client* ]]; then
  echo "[$var]" >> ../hosts
  echo "`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$var" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/.ssh/id_rsa" >> ../hosts
echo `aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$var" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text` >> iplist
fi

done < "$input"
rm -rf taglist
