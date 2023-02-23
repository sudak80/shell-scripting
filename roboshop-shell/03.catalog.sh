# source module will fetch the file content to this module/file.
source ./common.sh

echo -e "\e[35m Add nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
status_check

echo -e "\e[35m Install nodejs \e[0m"
yum install nodejs -y  &>>${LOG}
status_check

echo -e "\e[35m Add roboshop user \e[0m"
#useradd roboshop
status_check

mkdir -p /app

echo -e "\e[35m Download app content \e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>${LOG}
status_check

echo -e "\e[35m App cleanup \e[0m"
rm -rf /app/*
status_check

cd /app
echo -e "\e[35m Extracting app content \e[0m"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

cd /app
echo -e "\e[35m Installing NodeJs dependencies \e[0m"
npm install  &>>${LOG}
status_check

echo -e "\e[35m Configuring catalogue service file \e[0m"
cp ${config_file_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

echo -e "\e[35m Restart catalogue service \e[0m"
systemctl daemon-reload &>>${LOG}
status_check

echo -e "\e[35m Enable catalogue service \e[0m"
systemctl enable catalogue &>>${LOG}
status_check

echo -e "\e[35m Starting catalogue service \e[0m"
systemctl start catalogue &>>${LOG}
status_check

echo -e "\e[35m Download app content \e[0m"
#cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

echo -e "\e[35m Install mongodb client \e[0m"
yum install mongodb-org-shell -y &>>${LOG}
status_check

echo -e "\e[35m Loading catalogue schema \e[0m"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
status_check