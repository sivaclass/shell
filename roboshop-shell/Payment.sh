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

dnf install python36 gcc python3-devel -y &>>$LOGFILE
VALIDATE $? "install python 36"
id roboshop 
if [ $? -ne 0 ]
then
    useradd roboshop
    echo " roboshop is created"
else
    echo "user roboshop existed"
fi
mkdir -p /app &>>$LOGFILE
curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>>$LOGFILE
VALIDATE $? "downloading payment zip file"
cd /app
unzip /tmp/payment.zip &>>$LOGFILE
VALIDATE $? "unzip payment"
pip3.6 install -r requirements.txt &>>$LOGFILE
VALIDATE $? "install reqirements"
cp /home/centos/shell/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>$LOGFILE
VALIDATE $? "copy payment.service"
systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "daemon-reload"
systemctl enable payment &>>$LOGFILE
VALIDATE $? "enable payment"
systemctl start payment &>>$LOGFILE
VALIDATE $? "start payment"