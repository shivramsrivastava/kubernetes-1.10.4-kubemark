#! /bin/bash
source ~/.profile
mkdir go
cd go
mkdir src
cd src
go get -d github.com/kubernetes-sigs/poseidon
cd github.com/kubernetes-sigs/poseidon/cmd/poseidon
go build
#./poseidon --kubeConfig=/home/ubuntu/.kube/config --firmamentAddress=0.0.0.0 --logtostderr --v 3 --schedulingInterval=10 --schedulingInterval 4
