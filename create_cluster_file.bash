#! /bin/bash

function create_cluster_file() {
	FDB_CLUSTER_FILE=${FDB_CLUSTER_FILE:-/etc/foundationdb/fdb.cluster}
	mkdir -p $(dirname $FDB_CLUSTER_FILE)

	if [[ -n "$FDB_CLUSTER_FILE_CONTENTS" ]]; then
		echo "$FDB_CLUSTER_FILE_CONTENTS" > $FDB_CLUSTER_FILE
	elif [[ -n $FDB_COORDINATOR ]]; then
		coordinator_ip=$(dig +short $FDB_COORDINATOR)
		if [[ -z "$coordinator_ip" ]]; then
			echo "Failed to look up coordinator address for $FDB_COORDINATOR" 1>&2
			exit 1
		fi
		echo "docker:docker@$coordinator_ip:31111" > $FDB_CLUSTER_FILE
	else
		echo "FDB_COORDINATOR environment variable not defined" 1>&2
		exit 1
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    create_cluster_file "$@"
fi