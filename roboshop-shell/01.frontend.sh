#Hear we are going automate frontend server configuration...
config_file_location=$(pwd)

echo -e "\e[35m Install Nginx\e[0m"
yum install nginx -y

rm -rf /usr/share/nginx/html/*

echo -e "\e[35m Download Frontend content(Artifacts)\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html
echo -e "\e[35m Extract Frontend\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[35m Copy config File\e[0m"
cp ${config_file_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35m Enable Nginx\e[0m"
systemctl enable nginx

echo -e "\e[35m Start Nginx\e[0m"
systemctl start nginx

echo -e "\e[35m Restart Nginx\e[0m"
systemctl restart nginx