#!bin/bash

rm -rf /rmp/*.pid


IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
echo "CONTAINER_IP=$IP"

mongod --auth --bind_ip $IP

/bin/bash

