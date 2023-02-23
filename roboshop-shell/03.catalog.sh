# source module will fetch the file content to this module/file.
source ./00.common.sh

print_head "Add nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
status_check

print_head "Install nodejs"
yum install nodejs -y  &>>${LOG}
status_check

print_head "Add roboshop user"
#useradd roboshop
status_check

mkdir -p /app

print_head "Download app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>${LOG}
status_check

print_head "App cleanup"
rm -rf /app/*
status_check

cd /app
print_head "Extracting app content"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

cd /app
print_head "Installing NodeJs dependencies"
npm install  &>>${LOG}
status_check

print_head "Configuring catalogue service file"
cp ${config_file_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

print_head "Restart catalogue service"
systemctl daemon-reload &>>${LOG}
status_check

print_head "Enable catalogue service"
systemctl enable catalogue &>>${LOG}
status_check

print_head "Starting catalogue service"
systemctl start catalogue &>>${LOG}
status_check

print_head "Download app content"
#cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_head "Install mongodb client"
yum install mongodb-org-shell -y &>>${LOG}
status_check

print_head "Loading catalogue schema"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
status_check