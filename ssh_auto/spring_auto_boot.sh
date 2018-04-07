#!/bin/bash
cp -rpf /home/IOT-Pavan-Keypair.pem .
client=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=testc" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text`
ssh -o StrictHostKeyChecking=no -i "IOT-Pavan-Keypair.pem" ec2-user@"$client" <<'ENDSSH' 
sudo su
yum update -y
yum install wget -y
yum install git -y
cd  /opt
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz"
tar xzf jdk-8u161-linux-x64.tar.gz
rm -rf jdk-8*
alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 2
#opt for 1
#alternatives --config java
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_161/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_161/bin/jar
alternatives --set javac /opt/jdk1.8.0_161/bin/javac


#Install MAVEN*****
cd /usr/local
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
sudo tar xzf apache-maven-3.5.3-bin.tar.gz
sudo ln -s apache-maven-3.5.3  maven
echo "export M2_HOME=/usr/local/maven" >> /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
cd /home/ec2-user
yum install unzip -y
wget http://www.mkyong.com/wp-content/uploads/2016/11/spring-boot-web-jsp.zip
unzip spring-boot*
rm -rf spring-boot-web-jsp.zip
cd spring-boot-web-jsp
mvn dependency:tree
#add this line
echo "logging.file: /tmp/applcation.log" >>/home/ec2-user/spring-boot-web-jsp/src/main/resources/application.properties
#mvn spring-boot:run
ENDSSH
rm -rf IOT-Pavan-Keypair.pem
