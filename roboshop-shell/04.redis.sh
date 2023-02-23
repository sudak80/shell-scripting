# source module will fetch the file content to this module/file.
source ./00.common.sh

echo -e "\e[35m Add redis repo \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
status_check

echo -e "\e[35m Enable redis  \e[0m"
dnf module enable redis:remi-6.2 -y
status_check

yum install redis -y
status_check

sed -i 's/10.0.0.0/0.0.0.0/g' /etc/redis.conf
status_check

systemctl enable redis
status_check

systemctl start redis
status_check