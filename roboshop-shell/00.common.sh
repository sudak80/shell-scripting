# Script for Deploying Catalog service
config_file_location=$(pwd)
#set -e
LOG=/tmp/roboshop.log

# Defining a function called status_check
status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS\e[0m"
  else
    echo -e "\e[31m FAILURE\e[0m"
    echo "Refer logs at /tmp/roboshop.log"
  exit
  fi
}

print_head() {
  echo -e "\e[1m $1 \e[0m"
}