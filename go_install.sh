#! /bin/bash
wget https://storage.googleapis.com/golang/go1.10.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
sudo echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
rm go1.10.3.linux-amd64.tar.gz
