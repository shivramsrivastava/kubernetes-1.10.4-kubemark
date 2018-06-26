#!/bin/bash
sudo rm /etc/kubernetes/manifests/kube-scheduler.yaml
echo "Time at the start: " $(date +%H:%M:%S:%N)

output=$(pgrep kube-scheduler)
while [ "${output}" ]; do
  output=$(pgrep kube-scheduler)
  echo "Kube-scheduler running" $output
done
echo "Kube-scheduler stopped  at " $(date +%H:%M:%S:%N)
