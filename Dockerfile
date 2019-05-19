FROM foundationdb/foundationdb

# Set up extended runtime scripts and directories
COPY fdb_extended.bash scripts/
COPY create_server_environment.bash scripts/
COPY create_cluster_file.bash scripts/

RUN chmod u+x scripts/*.bash 

CMD /var/fdb/scripts/fdb_extended.bash

# Runtime configuration options

ENV FDB_NETWORKING_MODE kubernetes
ENV FDB_PORT="31111"
ENV KUBE_NODE_EXTERNAL_IP "192.168.0.8"