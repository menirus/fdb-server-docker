#! /bin/bash

function create_cluster_file() {
	FDB_CLUSTER_FILE=${FDB_CLUSTER_FILE:-/etc/foundationdb/fdb.cluster}
	mkdir -p $(dirname $FDB_CLUSTER_FILE)

	if [[ -n "$FDB_CLUSTER_FILE_CONTENTS" ]]; then
		echo "$FDB_CLUSTER_FILE_CONTENTS" > $FDB_CLUSTER_FILE
	elif [[ -n $FDB_COORDINATOR ]]; then
		if [[ "$FDB_NETWORKING_MODE" != "kubernetes" ]]; then
			coordinator_ip=$KUBE_NODE_EXTERNAL_IP
			# Handle empty kube_node_external_ip here, if necessary
			echo "kubernetes:kubernetes@$coordinator_ip:$FDB_PORT" > $FDB_CLUSTER_FILE
		else
			coordinator_ip=$(dig +short $FDB_COORDINATOR)
			if [[ -z "$coordinator_ip" ]]; then
				echo "Failed to look up coordinator address for $FDB_COORDINATOR" 1>&2
				exit 1
			fi
			echo "docker:docker@$coordinator_ip:4500" > $FDB_CLUSTER_FILE
		fi
	else
		echo "FDB_COORDINATOR environment variable not defined" 1>&2
		exit 1
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    create_cluster_file "$@"
fi