#! /usr/bin/python
import sys
import os
import commands

if len(sys.argv) <= 2:
  print("Minimum one argument needed for this python file!")
else:
  print commands.getoutput("mkdir -p normal_pods_rs")
  for index in range(int(sys.argv[1])):
     f = open("template_normal_pod_rs.yaml", "r")
     filedata = f.read()
     f.close()
     #filedata = filedata.replace("key", "key" + str(index))
     #filedata = filedata.replace("value", "value" + str(index))
     filedata = filedata.replace("cpureq", str(int(sys.argv[3])) + "m")
     filedata = filedata.replace("memreq", str(int(sys.argv[4])) + "Mi")
     filedata = filedata.replace("cpulim", str(int(sys.argv[5])) + "m")
     filedata = filedata.replace("memlim", str(int(sys.argv[6])) + "Mi")
     filedata = filedata.replace("nginx-normal-pod", "nginx-normal-pod-" + str(index) + "-" + str(int(sys.argv[7])))
     filedata = filedata.replace("replicas_value", sys.argv[2])
     newfile = "normal_pod_rs_" + str(index) + "_" + str(int(sys.argv[7])) + ".yaml"
     f_new = open("normal_pods_rs/" + newfile, "w")
     f_new.write(filedata)
     f_new.close()
     cmd = "kubectl create -f " + "normal_pods_rs/" + newfile
     #os.system(cmd)
     print commands.getoutput(cmd)
