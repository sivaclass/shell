#!/bin/bash
ID=$(id -u)
LOGFILE="/tmp/vijay$(date)-$0.log"
if [ $ID -ne 0 ]
then
    echo "pls login with ROOT user"
else
    echo " your ROOT user"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " Install $2 Failed"
    else
        echo -e " install $2 success"
    fi
}
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y &>> $LOGFILE
VALIDATE $? "install mongodb"
systemctl enable mongod &>> $LOGFILE
VALIDATE $? "enable mongod"
systemctl start mongod &>> $LOGFILE
VALIDATE $? "start mongod"
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

systemctl restart mongod &>> $LOGFILE
VALIDATE $? "restarted mongod" 