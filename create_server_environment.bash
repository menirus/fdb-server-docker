#! /bin/bash

source /var/fdb/scripts/create_cluster_file.bash

function create_server_environment() {
	fdb_dir=/var/fdb
	env_file=$fdb_dir/.fdbenv

	: > $env_file

	if [[ "$FDB_NETWORKING_MODE" == "host" ]]; then
		public_ip=127.0.0.1
	elif [[ "$FDB_NETWORKING_MODE" == "container" ]]; then
		public_ip=$(grep `hostname` /etc/hosts | sed -e "s/\s *`hostname`.*//")
	elif [[ "$FDB_NETWORKING_MODE" == "kubernetes" ]]; then
                public_ip=$KUBE_NODE_EXTERNAL_IP
	else
		echo "Unknown FDB Networking mode \"$FDB_NETWORKING_MODE\"" 1>&2
		exit 1
	fi

	echo "export PUBLIC_IP=$public_ip" >> $env_file
	if [[ -z $FDB_COORDINATOR ]]; then
		FDB_CLUSTER_FILE_CONTENTS="docker:docker@$public_ip:$FDB_PORT"
	fi

	create_cluster_file
}
