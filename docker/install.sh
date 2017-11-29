#!/bin/bash

# install vim with gui
echo ''
echo "Now installing docker..."
echo ''
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

# add user to docker group
echo ''
echo "add user to docker group..."
echo ''
sudo usermod -aG docker ${USER}
su - ${USER}

