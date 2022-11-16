#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
TOKEN="XXXXXXXXXXXXXXX"
cd /home/ec2-user && git clone https://$TOKEN@github.com/RamizMrt/deneme-phonebook.git
python3 /home/ec2-user/deneme-phonebook/phonebook-app.py