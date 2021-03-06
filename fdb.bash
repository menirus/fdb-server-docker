#! /bin/bash

source /var/fdb/scripts/create_server_environment.bash
create_server_environment
source /var/fdb/.fdbenv
echo "Starting FDB server on 35.194.5.18:31111"
fdbserver --listen_address 0.0.0.0:$FDB_PORT --public_address 35.194.5.18:31111 \
	--datadir /var/fdb/data --logdir /var/fdb/logs \
	--locality_zoneid=`hostname` --locality_machineid=`hostname` --class $FDB_PROCESS_CLASS