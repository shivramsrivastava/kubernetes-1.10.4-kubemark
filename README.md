# kubernetes-1.10.4-kubemark
Added scripts that setup docker 17.03 and kubeadm 1.10.4 and also added scipts which helps in building firmament, poseidon.

setup_docker_17.03_kubeadm_v1.10.4.sh -
* Removes unused docker images, containers and old docker installs.
* Freshly installs docker 17.03, which is recommended for kubeadm 1.10.4
* Remove existing kubeadm setup if any, and then installs kubeadm 1.10.4.
