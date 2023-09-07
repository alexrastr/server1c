#!/bin/bash

chown --recursive usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8
sed -i 's#NH_SERVER_ADDR =.*#NH_SERVER_ADDR = '"${HASP_IP}"'#' /opt/1cv8/conf/nethasp.ini

exec gosu usr1cv8 /opt/1cv8/x86_64/${VERSION_1C}/ragent

exec "$@"