#! /bin/bash
if [ "$(whoami)" != "root" ]
then
    sudo su -s "$0"
    exit
fi
sudo docker system prune -a
sudo apt-get remove docker docker-engine docker.io
sudo apt-get purge docker-ce
sudo rm -rf /var/lib/docker
echo "CLEANED OLD DOCKER AND NOW WILL INSTALL DOCKER 18.06.."
# If update is failing due to public key is not available: NO_PUBKEY isseu,
# use below link and fix it, Refer: https://kowalczyk.me/error-occurred-during-the-signature-verification/
sudo apt-get update
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
    exit 1
fi
# Install Docker from Ubuntu's repositories:
apt-get update
apt-get install -y docker.io

# or install Docker CE 18.06 from Docker's repositories for Ubuntu or Debian:

## Install prerequisites.
apt-get update && apt-get install apt-transport-https ca-certificates curl software-properties-common

## Download GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

## Add docker apt repository.
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Install docker.
apt-get update && apt-get install docker-ce=18.06.0~ce~3-0~ubuntu

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

#add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
#apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
echo "INSTALLED DOCKER 18.06."
echo "LETS START INSTALLING KUBEADM"
# sometimes there may be two duplicate entries /etc/apt/sources.list.d/kubernetes.list,
# comment one and avoid warning in apt-get update.
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get remove kubelet kubeadm kubectl
apt-get update
apt-get install -y kubelet kubeadm kubectl
echo "Installed kubeadm kubelet kubectl 1.12.3"
# Be careful with below command, edit manully if you ran this script earlier.
# sed -i 's/--kubeconfig=\/etc\/kubernetes\/kubelet.conf/--kubeconfig=\/etc\/kubernetes\/kubelet.conf --max-pods=210 --cgroup-driver=cgroupfs/' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet
