#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIME=$(date +%F-%H-%M)
LOGFILE="/tmp/vijay$(date)-$0.log"
if [ $ID -ne 0 ]
then
    echo "pls login with ROOT user"
    exit 1
else
    echo " your are ROOT user"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " $R Failed $2 $N"
        exit 1
    else
        echo -e "$G successfull $2 $N"
    fi
}
dnf module disable mysql -y &>> LOGFILE
VALIDATE $? "disable mysql"
cp /home/centos/shell/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>> LOGFILE
VALIDATE $? "copying mysql repo"
dnf install mysql-community-server -y &>> LOGFILE
VALIDATE $? "Install MySQL Server"
systemctl enable mysqld &>> LOGFILE
VALIDATE $? "enable mysqld"
systemctl start mysqld &>> LOGFILE
VALIDATE $? "start mysqld"
mysql_secure_installation --set-root-pass RoboShop@1 &>> LOGFILE
VALIDATE $? "root password setup"