#!/bin/sh

set -ex

CONFIG_FILE="${CONFIG_FILE:-/etc/certbot/config.ini}"
HOSTS_FILE="${HOSTS_FILE:-/etc/certbot/hosts.ini}"

if [ -z "${EMAIL}" ]
then
  echo "can not continue without EMAIL set"
  exit 5
fi

while read line; do
  # HOSTS=$(echo -n "-d \"${line}\"" | sed 's/,/" \-d "/g')
  HOSTS=$(echo -n "-d ${line}" | sed 's/,/ \-d /g')
  certbot certonly --non-interactive --agree-tos -m ${EMAIL} --dns-rfc2136 --dns-rfc2136-credentials ${CONFIG_FILE} ${HOSTS} 
done < ${HOSTS_FILE}

