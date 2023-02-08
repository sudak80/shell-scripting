# Script for Deploying Catalog service
config_file_location=$(pwd)
#set -e

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
#useradd roboshop
mkdir -p /app

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
rm -rf /app/*
unzip /tmp/catalogue.zip
npm install

cp ${config_file_location}/files/catalogue.service /etc/systemd/system/catalogue.service
cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
