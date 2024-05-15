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
dnf install nginx -y &>>$LOGFILE
VALIDATE $? "nginx install"
systemctl enable nginx &>>$LOGFILE
VALIDATE $? "enable nginx"
systemctl start nginx &>>$LOGFILE
VALIDATE $? "start nginx"
rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing Default nginx path"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>$LOGFILE
VALIDATE $? "Downloading web"
cd /usr/share/nginx/html 

unzip /tmp/web.zip &>>$LOGFILE
VALIDATE $? "Unzip web"
cp /home/centos/shell/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$LOGFILE
VALIDATE $? "copying Roboshop  Config file"
systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restating NGINX"