# mongodb configuration details
config_file_location=$(pwd)
set -e    # This will stop wherver issue occurs and will not proceed further.

cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org -y

sed -i 's/10.0.0.0/0.0.0.0/g' /etc/mongod.conf

systemctl enable mongod
systemctl start mongod
systemctl restart mongod