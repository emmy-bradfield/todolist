#!/usr/bin/env bash
# Script to Build Python 3.6.3 for Ubuntu 16.04
#
# Ubuntu 16.04 is and LTS release with Python for System use locked at 3.5
# This script builds Python3.6 from source and installs it in /usr/local
#
# Called from my VagrnantFile as
# config.vm.provision :shell, inline: "bash /var/www/myproj/VagrantScripts/BuildPython36.sh"
#
# Inspired by the wonderful instructions at 
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/
#
#

echo "============================================"
echo "Installing Python3.6 from Source"
echo "============================================"

# Check for existing Python 3.6.3

if [ -d ./Python-3.6.3/ ]
 then
   echo "Python3.6 Installed, deleting source files"
   rm -rf ./Python-3.6.3
   rm ./Python-3.6.3.tar.xz
fi
echo "============================================"
echo "Installing required dev libraries"
echo "============================================"
sudo apt-get install -y  zlib1g-dev libssl-dev libbz2-dev libncurses5-dev libsqlite0-dev libreadline-dev
sudo apt-get install -y tk8.5-dev libdb4o-cil-dev libgdbm-dev
echo "============================================"
echo "Downloading Source"
echo "============================================"
wget http://python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
tar xf Python-3.6.3.tar.xz
cd Python-3.6.3
echo "============================================"
echo "Building "
echo "============================================"
sudo ./configure --prefix=/usr/bin --enable-shared LDFLAGS="-Wl,-rpath /usr/bin/"
sudo make
sudo make altinstall

echo "============================================"
echo "Install PIP"
echo "============================================"
# First get the script:
wget https://bootstrap.pypa.io/get-pip.py
python3.6 get-pip.py

echo "============================================"
echo "Creating and Installing Virtualenv"
echo "============================================"
mkdir /home/ubuntu/myproj/venv
python3.6 -m venv /home/ubuntu/myproj/venv
#Activate the venv
source /home/ubuntu/myproj/venv/bin/activate
#install required packages
cd /var/www/myproj
echo "============================================"
echo "Installing requirements.txt"
echo "============================================"
pip3 install -r requirements.txt

echo "============================================"
echo "Python Setup Complete."
echo "============================================"
