#!/bin/bash

# check db directory for emptiness
if [ -z "$(ls -A /data)" ]; then
    echo $PGPASSWORD > /tmp/pwfile
    initdb --pgdata /data -A md5 --username postgres --pwfile=/tmp/pwfile 
    rm /tmp/pwfile
    echo "listen_addresses = '*'" >> /data/postgresql.conf
    echo "host    all    all    0.0.0.0/0    md5" >> /data/pg_hba.conf
fi

exec postgres -D /data > /var/log/postgres/log 2>&1

exec "$@"