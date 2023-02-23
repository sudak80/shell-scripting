# source module will fetch the file content to this module/file.
source ./00.common.sh

#echo -e "\e[35m Install Nginx\e[0m"

print_head "Install nginx"
yum install nginx -y &>>${LOG}
# echo $?   - To display command run status whether it is failed or success
# echo is to display else we can use only $? also.
status_check

#echo -e "\e[35m Remove old Nginx content files\e[0m"
print_head "Remove old Nginx content files"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "Download Frontend content(Artifacts)"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

cd /usr/share/nginx/html &>>${LOG}

print_head "Extract Frontend"
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "Copy config File"
cp ${config_file_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "Enable Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "Start Nginx"
systemctl start nginx
status_check

print_head "Restart Nginx"
systemctl restart nginx &>>${LOG}
status_check