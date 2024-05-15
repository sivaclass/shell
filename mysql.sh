#!/bin/bash
ID=$(id -u)
LOGFILE=/tmp/$(date)-$0
R=/e31m
G=/e32m
N=/0m
if [ $ID -ne 0 ]
then
echo " please take root access "
else
echo " you are in root user "
fi
VALIDATE() {
    if [ $1 -ne 0 ]
then
echo " $2 $R not installed $N"
else
echo " $2 installation suceess $G you can proceed $N"
fi
   
}

yum install mysql -y &>> $LOGFILE
VALIDATE $? "mysql"
yum install git -y &>> $LOGFILE
VALIDATE $? "git"
