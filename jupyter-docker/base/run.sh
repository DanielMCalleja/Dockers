#!bin/bash

rm -rf /rmp/*.pid


IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
echo "CONTAINER_IP=$IP"

jupyter notebook --ip $IP --allow-root --port 8888 --no-browser --notebook-dir='/data/notebooks'

#jupyter notebook --ip $IP --allow-root --port 8888 --no-browser


/bin/bash

