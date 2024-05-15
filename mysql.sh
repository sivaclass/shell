#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then
echo " please take root access "
else
echo " you are in root user "
fi
VALIDATE() {
    if [ $? -ne 0 ]
then
echo " git not installed"
else
echo " git installation suceess "
fi
   
}

yum install mysql -y
VALIDATE
yum install git -y
VALIDATE
