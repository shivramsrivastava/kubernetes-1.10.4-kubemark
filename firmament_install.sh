#! /bin/bash
sudo apt-get update
sudo apt-get install build-essentials
sudo apt-get install -y cmake
sudo apt-get install -y pkg-config
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install -y libctemplate-dev
sudo apt-get update
sudo apt-get install -y libssl-dev

git clone https://github.com/Huawei-PaaS/firmament.git -b dev
cd firmament
make
cd build
make -j16


# /build/src/firmament_scheduler -flagfile config/firmament_scheduler_cpu_mem.cfg -max_multi_arcs_for_cpu 5 --debug_cost_model=true -debug_flow_graph 1 -logtostderr -log_solver_stderr -max_tasks_per_pu 90

