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
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
VALIDATE $? "install rpms package"
dnf module enable redis:remi-6.2 -y &>> $LOGFILE
VALIDATE $? "enable redis"
dnf install redis -y &>> $LOGFILE
VALIDATE $? "installing Redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf &>> $LOGFILE

systemctl enable redis &>> $LOGFILE
VALIDATE $? "enable redis"
systemctl start redis &>> $LOGFILE
VALIDATE $? "start redis"