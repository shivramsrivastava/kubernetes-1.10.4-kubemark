#! /usr/bin/python
import os
import commands

print commands.getoutput("rm -rf ./normal_pods_rs")

op = commands.getoutput("kubectl get rs")

split = op.split("\n")

split = split[1:]

for line in split:
  cmd = "kubectl delete rs " + line.split(" ")[0] + " &"
  os.system( cmd )
