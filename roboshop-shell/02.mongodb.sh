# mongodb configuration details
config_file_location=$(pwd)
set -e

cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod

sed -i 's/10.0.0.0/0.0.0.0/g' /etc/mongod.conf

systemctl restart mongod