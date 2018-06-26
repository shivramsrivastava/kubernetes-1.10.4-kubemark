#!/usr/bin/python
import commands
import pdb

op = commands.getoutput("kubectl get nodes")
lines = op.split("\n")

nodes = []
lines = lines[1:]
for line in lines:
   nodes.append(line.split()[0])

#nodes.reverse()

print nodes

for node in nodes:
#   op = commands.getoutput("kubectl drain %s --delete-local-data --force --ignore-daemonsets" % node)
#   print op
#   op = commands.getoutput("kubectl delete node %s" % node)
    op = commands.getoutput("kubectl describe nodes %s | grep 'pods:		'" % node)
    print "%s %s" % ( node, op)


