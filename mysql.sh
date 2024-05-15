#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then
echo " please take root access "
else
echo " you are in root user "
fi

yum install mysql -y
if [ $? -ne 0 ]
then
echo " mysql not installed"
else
echo " mysql installation suceess "
fi

yum install git -y
if [ $? -ne 0 ]
then
echo " git not installed"
else
echo " git installation suceess "
fi