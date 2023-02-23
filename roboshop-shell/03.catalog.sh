# Script for Deploying Catalog service
config_file_location=$(pwd)
#set -e
LOG=/tmp/roboshop.log

echo -e "\e[35m Add nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Install nodejs \e[0m"
yum install nodejs -y  &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Add roboshop user \e[0m"
#useradd roboshop
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
  echo "Refer log file at /tmp/roboshop.log"
exit
fi

mkdir -p /app

echo -e "\e[35m Download app content \e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m App cleanup \e[0m"
rm -rf /app/*
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

cd /app
echo -e "\e[35m Extracting app content \e[0m"
unzip /tmp/catalogue.zip &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

cd /app
echo -e "\e[35m Installing NodeJs dependencies \e[0m"
npm install  &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Configuring catalogue service file \e[0m"
cp ${config_file_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Restart catalogue service \e[0m"
systemctl daemon-reload &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Enable catalogue service \e[0m"
systemctl enable catalogue &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Starting catalogue service \e[0m"
systemctl start catalogue &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Download app content \e[0m"
#cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Install mongodb client \e[0m"
yum install mongodb-org-shell -y &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi

echo -e "\e[35m Loading catalogue schema \e[0m"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
exit
fi