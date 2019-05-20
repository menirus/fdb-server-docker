#! /bin/bash

source /var/fdb/scripts/create_server_environment.bash
create_server_environment
source /var/fdb/.fdbenv
echo "Starting FDB server on $PUBLIC_IP:$FDB_PORT"
echo $(getent hosts $PUBLIC_IP)
fdbserver --listen_address 0.0.0.0:$FDB_PORT --public_address $PUBLIC_IP:$FDB_PORT \
	--datadir /var/fdb/data --logdir /var/fdb/logs \
	--locality_zoneid=`hostname` --locality_machineid=`hostname` --class $FDB_PROCESS_CLASS

echo "Hello, world!"
