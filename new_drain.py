#!/usr/bin/python
# This drains workers first and drain master at the end.
import commands
import pdb

op = commands.getoutput("kubectl get nodes")
lines = op.split("\n")

nodes = []
lines = lines[1:]
for line in lines:
   nodes.append(line.split()[0])

nodes.reverse()

print nodes

for node in nodes:
   if 'master' in node:
      master_node_name = node
      print node
   else:
      op = commands.getoutput("kubectl drain %s --delete-local-data --force --ignore-daemonsets" % node)
      print op
      op = commands.getoutput("kubectl delete node %s" % node)
      print op

op = commands.getoutput("kubectl drain %s --delete-local-data --force --ignore-daemonsets" % master_node_name)
print op
op = commands.getoutput("kubectl delete node %s" % master_node_name)
print op
