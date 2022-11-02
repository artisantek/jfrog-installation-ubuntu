#!/bin/bash

sudo apt-get update -y 1>/dev/null
sudo apt-get install boxes 1>/dev/null
echo "Artisan Tek\n\n\nJFROG Artifactory Installation" | boxes -d bear -a c

# Installing necessary packages
echo "\n\n################################################################"
echo "\n*****Installing necessary packages"
sudo apt-get install -y default-jre 1>/dev/null
echo "            -> Done"

# Configuring Artifactory as a Service
echo "*****Configuring Artifactory as a Service"
sudo useradd -r -m -U -d /opt/artifactory -s /bin/false artifactory 2>/dev/null
sudo cp artifactory.service /etc/systemd/system/artifactory.service
sudo systemctl daemon-reload 1>/dev/null
echo "            -> Done"

# Downloading JFROG Artifactory 6.9.6 version to OPT folder
echo "*****Downloading JFROG Artifactory 6.9.6 version"
sudo systemctl stop artifactory > /dev/null 2>&1
cd /opt 
sudo rm -rf jfrog* artifactory*
sudo wget -q https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
sudo unzip -q jfrog-artifactory-oss-6.9.6.zip -d /opt/artifactory 1>/dev/null
sudo chown -R artifactory: /opt/artifactory/*
sudo rm -rf jfrog-artifactory-oss-6.9.6.zip
echo "            -> Done"

# Starting Artifactory Service
echo "*****Starting Artifactory Service"
sudo systemctl start artifactory 1>/dev/null


# Check if Artifactory is working
sudo systemctl is-active --quiet artifactory
echo "\n################################################################ \n"
if [ $? -eq 0 ]; then
	echo "Artifactory installed Successfully"
	echo "Access Artifactory using $(curl -s ifconfig.me):8081"
else
	echo "Artifactory installation failed"
fi
echo "\n################################################################ \n"

