#!/bin/bash
echo $'\nSSO - ORDINARY EXAM - Gerardo Escareno Vazquez - ID:1584018'
read -p "Press enter to continue"

OS=$(cat /etc/*-release | grep -w PRETTY_NAME | cut -d= -f2 | tr -d '"')
echo ""
echo "YOUR OPERATING SYSTEM: $OS"
read -p "Press enter to continue"

echo $'\n####  ----  Checking if ClamAV is installed.  ----  ####'
if rpm -q clamav; then
    echo $'\n####  ----  ClamAV is currently installed. Proceeding to uninstall current version.  ----  ####'
    read -p "Press enter to continue"
    sudo systemctl stop clamd@scan
    sudo systemctl disable clamd@scan
    sudo yum remove clamav* -yv
    echo $'\n####  ----  The current version of ClamAV was uninstalled.  ----  ####'
    sleep 3
    echo $'\n####  ----  Installing a new version of ClamAV.  ----  ####'
    read -p "Press enter to continue"
    sudo yum -y install epel-release
    sudo yum clean all
    sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
    echo $'\n####  ----  Updating ClamAV virus definition database.  ----  ####'
    read -p "Press enter to continue"
    sudo freshclam
else
    echo $'\n####  ----  Installing a new version of ClamAV.  ----  ####'
    read -p "Press enter to continue"
    sudo yum -y install epel-release
    sudo yum clean all
    sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
    echo $'\n####  ----  Updating ClamAV virus definition database.  ----  ####'
    read -p "Press enter to continue"
    sudo freshclam
fi

echo $'\n####  ----  Checkin if EPEL-Release is installed.  ----  ####'
if rpm -q epel-release; then
    echo $'\n####  ----  EPEL-Release is currently installed. Proceeding to list your repos.  ----  ####'
    read -p "Press enter to continue"
    sudo yum repolist
else
    echo $'\n####  ----  Installing EPEL-Release.  ----  ####'
    read -p "Press enter to continue"
    sudo wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo rpm -ivh epel-release-latest-7.noarch.rpm
    echo $'\n####  ----  EPEL-Release was installed successfully. Proceeding to list your repos  ----  ####'
    read -p "Press enter to continue"
    sudo yum repolist
fi

echo $'\n####  ----  Cheking for updates.  ----  ####'
read -p "Press enter to continue"
if yum list updates; then
    echo $'\n####  ----  Updating packages.  ----  ####'
    read -p "Press enter to continue"
    sudo yum -y update
else
    echo $'\n####  ----  There are no packages to update.  ----  ####'
fi