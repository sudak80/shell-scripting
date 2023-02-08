curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
cd /app
npm install
cp ${config_file_location}/files/user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user

#cp ${config_file_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y

mongo --host localhost </app/schema/user.js