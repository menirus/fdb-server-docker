# fdb-server-docker

The aim of this repo is to get modify the docker image to deploy foundationdb in a Kubernetes cluster.

## What I did to deploy fdb cluster and discover it from outside world?
* Extended the official foundationdb docker image to support a new environment variable "KUBE_NODE_EXTERNAL_IP" 
* Passed in the ExternalIP of the kubernetes node using the above env (kubectl get nodes -o wide)
* Modified the fdb.bash to run the fdbserver with public address as the passed Node's ExternalIP 
* Added the port 31111 to kubernetes node firewall (google add firewall entry in gcloud node)

## Drawbacks
* Resiliency went for a toss, since we are basically fixing the NodeIP
* I don't think this approach would pan out when we expand the cluster to more nodes and add replication factor
* I couldn't find a neat way to pass in ExternalIP in the spec sheet, have to figure out some way to do it before our fdb.bash runs
* Do we need to expose reader nodes IPs as well? Because clients directly connect to the reader nodes for 

## Next steps
* Where do StatefulSets fit in the picture?
* Where do PersistentVolumes fit in the picture? Only stateful pods need them I presume
* Ingress is the next logical way to try out?
