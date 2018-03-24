
*******Install Ansible Latest version in Ubuntu like below:-    <br/>
sudo apt-get remove --purge ansible         <br/>
sudo apt-add-repository ppa:ansible/ansible  <br/>
sudo apt-get update -y                  <br/>
sudo apt-get install ansible -y    <br/>


-> Login to ubuntu Ansible   <br/>
-> sudo su    <br/>
-> Before this step do the ssh procedure(Like how we did in previous repo using "ssh_auto.sh") to the ELK clients and server from Ansible server <br/>
-> In the repo change the "hosts" file with your ELK clients and server ip addresses. <br/>

*******Do the below steps:- <br/>
git clone https://github.com/pavank1933/ELK_ANSIBLE_DEMO.git  <br/>
cd ELK_ANSIBLE_DEMO  <br/>
ansible-playbook -i hosts install/elk.yml <br/>

*******After this:-  <br/>
Navigate to the ELK at http://ELK_SERVER_IP:80  <br/>
Default login is: <br/>
username: admin <br/>
password: admin <br/>



*****ELK Client Instructions****** <br/>
Run the client playbook against the generated elk_server variable <br/>
ansible-playbook -i hosts install/elk-client.yml --extra-vars 'elk_server=X.X.X.X' <br/>




******Error Workouts*******  <br/>
unsupported parameter for module: path    -> This i resolved using ansible latest version <br/>


*****I manually executed this in rhel elk server to over come rpmdb(db5) issue*** <br/> 
rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent <br/>
 
 
*****elk issues***** <br/>
Issue name:- Error installing fluent-plugin-elasticsearch ERROR: Failed to build gem native extension <br/>

Sol:- yum install gcc gcc-c++ ruby-devel -y resolved the issue-added this in ansible  <br/>