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
    exit 12
else
    echo " your ROOT user"
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
dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabled NODEJS"
dnf module enable nodejs:18 -y &>>$LOGFILE
VALIDATE $? "enabled NODEJS-18"
dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "installed NODEjs"
id roboshop 
if [ $? -ne 0 ]
then
    useradd roboshop
    echo " roboshop is created"
else
    echo "user roboshop existed"
fi
mkdir -p /app &>>$LOGFILE
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$LOGFILE
VALIDATE $? "catalogue downloading"
cd /app
unzip -o /tmp/catalogue.zip &>>$LOGFILE
VALIDATE $? "unzip catalogue"
cp /home/centos/shell/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>$LOGFILE
VALIDATE $? "copying catalogue"
systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Demaon Reload"
systemctl enable catalogue &>>$LOGFILE
VALIDATE $? "enable catalogue"
systemctl start catalogue &>>$LOGFILE
VALIDATE $? "start catalogue"
cp /home/centos/shell/roboshop-shell/catalogue.service /etc/yum.repos.d/mongo.repo &>>$LOGFILE
VALIDATE $? "coping mongo repo"
dnf install mongodb-org-shell -y &>>$LOGFILE
VALIDATE $? "install mongodb client"
mongo --host 172.31.24.47 < /app/schema/catalogue.js &>>$LOGFILE
VALIDATE $? "load schema"



    