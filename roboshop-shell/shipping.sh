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
dnf install maven -y &>>$LOGFILE
VALIDATE $? "installing maven"
id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop
    echo " roboshop is created"
else
    echo "user roboshop existed"
fi
mkdir -p /app 
VALIDATE $? "creating app directory"
curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>>$LOGFILE
VALIDATE $? "Downloading shipping"
cd /app
VALIDATE $? "moving to app directory"
unzip /tmp/shipping.zip &>>$LOGFILE
VALIDATE $? "unzipping shipping"
mvn clean package &>>$LOGFILE
VALIDATE $? "Installing dependencies"
mv target/shipping-1.0.jar shipping.jar &>>$LOGFILE
VALIDATE $? "renaming jar file"
cp /home/centos/shell/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>$LOGFILE
VALIDATE $? "copying shipping service"
systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "deamon reload"
systemctl enable shipping &>>$LOGFILE
VALIDATE $? "enable shipping"
systemctl start shipping &>>$LOGFILE
VALIDATE $? "start shipping"
dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install MySQL client"
mysql -h 172.31.28.137 -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$LOGFILE
VALIDATE $? "loading shipping data"
systemctl restart shipping &>>$LOGFILE
VALIDATE $? "restart shipping"