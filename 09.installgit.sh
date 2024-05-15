#! /bin/bash
ID=$(id -u)
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "ERROR:: failed"
    else
        echo "Installation is success.."
    fi
}
if [ $ID -ne 0 ]
then
    echo "pls login with ROOT user"
else
    echo "yes ROOT user"
fi
yum install git -y
VALIDATE $? "installed git"
