#!/bin/bash
sudo apt -y update 
sudo apt -y upgrade
sudo apt install -y unzip
sudo apt -y curl
sudo apt-get -y install curl apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt -y update
sudo apt install -y docker-ce
