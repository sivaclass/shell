#! /bin/bash
echo "$0"
DATE=$(date)
echo "today date is :${DATE}"
ID=$(id -u)
if [ $ID -ne 0 ]
then
echo " pls login with Root user"
exit 1
else
    echo " yes it's ROOt user"
fi
yum install nginx -y
