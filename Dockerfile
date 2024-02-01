FROM ubuntu:jammy

RUN apt-get update && apt-get install -y \
   python3-certbot-dns-rfc2136 \
 && rm -rf /var/lib/apt/lists/*

COPY get-certs.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/get-certs.sh" ]

