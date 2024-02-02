#!/bin/sh

docker buildx build --push --platform linux/amd64,linux/arm64 -t theempty/certbot-dns-rfc2136-collector --builder pensive_albattani .
