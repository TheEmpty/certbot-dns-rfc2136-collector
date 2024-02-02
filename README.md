Use to get and store your certificates from Let's Encrypt with certbot and a DNS server that uses nsupdate, like bind9.

* Docker image @ `theempty/certbot-dns-rfc2136-collector`
* required env var `EMAIL`
* see sample files or kube example below for configuration file setup


## Kubernetes Example

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: certbot-configuration
data:
  hosts.ini: |
    example.com,*.exmaple.com
    other.host.com
    seperated-by-lines.tld,combine-with-commas.seperated-by-lines.tld
  config.ini: |
    dns_rfc2136_server = 127.0.0.1
    dns_rfc2136_port = 53
    dns_rfc2136_name = certbot.
    dns_rfc2136_secret = YOUR_BASE64_SECRET_HERE
    dns_rfc2136_algorithm = HMAC-SHA512
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: certbot-daemon
spec:
  selector:
    matchLabels:
      app: certbot-daemon
  replicas: 1
  template:
    metadata:
      labels:
        app: certbot-daemon
        app.kubernetes.io/name: certbot-daemon
    spec:
      containers:
      - name: certbot-daemon
        image: theempty/certbot-dns-rfc2136-collector
        env:
          - name: EMAIL
            value: your@email.com
        volumeMounts:
          - name: certificate-storage
            mountPath: /etc/letsencrypt
          - name: certbot-configuration
            mountPath: /etc/certbot
      volumes:
        - name: certificate-storage
          persistentVolumeClaim:
            claimName: certbot-certificates-pvc
        - name: certbot-configuration
          configMap:
            name: certbot-configuration

```
