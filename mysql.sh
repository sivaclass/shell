#!/bin/bash
ID=$(id -u)
LOGFILE=/tmp/$(date)-$0
R="\e[31m"
G="\e[32m"
N="\e[0m"
if [ $ID -ne 0 ]
then
echo " please take root access "
else
echo " you are in root user "
fi
VALIDATE() {
    if [ $1 -ne 0 ]
then
echo -e " $2 $R not installed $N"
else
echo -e " $2 installation suceess $G you can proceed $N"
fi
   
}

yum install mysql -y &>> $LOGFILE
VALIDATE $? "mysql"
yum install git -y &>> $LOGFILE
VALIDATE $? "git"
