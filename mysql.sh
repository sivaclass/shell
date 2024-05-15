#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then
echo " please take root access "
else
echo " you are in root user "
fi
VALIDATE() {
    if [ $1 -ne 0 ]
then
echo " $2 not installed "
else
echo " $2 installation suceess you can proceed "
fi
   
}

yum install mysql -y
VALIDATE $? "mysql"
yum install git -y
VALIDATE $? "git"
