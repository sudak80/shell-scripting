# source module will fetch the file content to this module/file.
source ./00.common.sh

echo -e "\e[35m Creating mongodb repo\e[0m"
cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

echo -e "\e[35m Install mongodb\e[0m"
yum install mongodb-org -y &>>${LOG}
status_check

echo -e "\e[35m Allowing mongodb to accept traffic from anywhere (incoming)\e[0m"
sed -i 's/10.0.0.0/0.0.0.0/g' /etc/mongod.conf &>>${LOG}
status_check

echo -e "\e[35m Enable mongodb\e[0m"
systemctl enable mongod &>>${LOG}
status_check

echo -e "\e[35m Starting mongodb service\e[0m"
systemctl start mongod &>>${LOG}
status_check