# mongodb configuration details
config_file_location=$(pwd)
#set -e    # This will stop wherver issue occurs and will not proceed further.
LOG=/tmp/roboshop.log

echo -e "\e[35m Creating mongodb repo\e[0m"
cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
fi

echo -e "\e[35m Install mongodb\e[0m"
yum install mongodb-org -y &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
fi

echo -e "\e[35m Allowing mongodb to accept traffic from anywhere (incoming)\e[0m"
sed -i 's/10.0.0.0/0.0.0.0/g' /etc/mongod.conf &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
fi

echo -e "\e[35m Enable mongodb\e[0m"
systemctl enable mongod &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
fi

echo -e "\e[35m Starting mongodb service\e[0m"
systemctl start mongod &>>${LOG}
if [ $? -eq 0 ]
then
  echo "SUCCESS"
else
  echo "FAILURE"
fi