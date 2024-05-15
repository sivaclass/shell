#!/bin/bash
SU=($sudo su -)
if [ $SU -ne 0 ] ;
echo " you are not in user "
else
echo " you are in root user "
fi
ID=$(id -u)
if [ $ID -ne 0 ] ;
echo " please take root access "
else
echo " you are in root user "
fi

yum install mysql -y
if [ $? -ne 0 ] ;
echo " mysql not installed"
else
echo " mysql installation suceess "
fi