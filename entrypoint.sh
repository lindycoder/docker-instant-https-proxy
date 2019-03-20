#!/bin/bash -eu

# https://serverfault.com/questions/638822/nginx-resolver-address-from-etc-resolv-conf

if [ -z "${NAMESERVER-}" ]; then
    echo "Auto-detecting nameserver from /etc/resolv.conf"
	export NAMESERVER=`cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | tr '\n' ' '`
fi

echo "Nameserver is: $NAMESERVER"

echo "Copying nginx config to /etc/nginx/nginx.conf"
envsubst '$NAMESERVER' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "Using nginx config:"
cat /etc/nginx/nginx.conf

echo "Starting nginx"
nginx -g "daemon off;"
