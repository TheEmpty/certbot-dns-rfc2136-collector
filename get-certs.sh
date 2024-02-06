#!/bin/sh

set -x

CONFIG_FILE="${CONFIG_FILE:-/etc/certbot/config.ini}"
HOSTS_FILE="${HOSTS_FILE:-/etc/certbot/hosts.ini}"
SLEEP_TIME="${SLEEP_TIME:-86400}" # once a day

if [ -z "${EMAIL}" ]
then
  echo "can not continue without EMAIL set"
  exit 5
fi

while true; do

while read line; do
  # HOSTS=$(echo -n "-d \"${line}\"" | sed 's/,/" \-d "/g')
  HOSTS=$(echo -n "-d ${line}" | sed 's/,/ \-d /g')
  certbot certonly --non-interactive --agree-tos -m ${EMAIL} --expand --dns-rfc2136 --dns-rfc2136-credentials ${CONFIG_FILE} ${HOSTS}
done < ${HOSTS_FILE}

sleep ${SLEEP_TIME}

done
