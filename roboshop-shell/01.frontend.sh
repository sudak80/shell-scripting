# source module will fetch the file content to this module/file.
source common.sh

echo -e "\e[35m Install Nginx\e[0m"
yum install nginx -y &>>${LOG}
# echo $?   - To display command run status whether it is failed or success
# echo is to display else we can use only $? also.
status_check

echo -e "\e[35m Remove old Nginx content files\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

echo -e "\e[35m Download Frontend content(Artifacts)\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

cd /usr/share/nginx/html &>>${LOG}
echo -e "\e[35m Extract Frontend\e[0m"
unzip /tmp/frontend.zip &>>${LOG}
status_check

echo -e "\e[35m Copy config File\e[0m"
cp ${config_file_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

echo -e "\e[35m Enable Nginx\e[0m"
systemctl enable nginx &>>${LOG}
status_check

echo -e "\e[35m Start Nginx\e[0m"
systemctl start nginx
status_check

echo -e "\e[35m Restart Nginx\e[0m"
systemctl restart nginx &>>${LOG}
status_check