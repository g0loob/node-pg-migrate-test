#!/bin/bash
set -e

for count in {1..100}; do
    echo "Pinging database attempt "${count}
    if  $(nc -z ${DB_HOST} ${DB_PORT}) ; then
        echo "Can connect into database"
        break
    fi
    sleep 3
done

npm run migrate up

exec "$@"
