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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> $LOGFILE
VALIDATE $? "Downloading erlang script"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> $LOGFILE
VALIDATE $? "Downloading rabbitmq script"
dnf install rabbitmq-server -y &>> $LOGFILE
VALIDATE $? "installing Robbitmq"
systemctl enable rabbitmq-server &>> $LOGFILE
VALIDATE $? "enableing Robbitmq-server"
systemctl start rabbitmq-server &>> $LOGFILE
VALIDATE $? "start rabbitmq-server"
rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE
VALIDATE $? "creating user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>> $LOGFILE
VALIDATE $? "setting permission"