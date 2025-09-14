# Self-signed TLS with a Private CA (Traefik)

This guide shows how to create and use a self-signed certificate for Traefik that your clients (browsers, apps, OS) will accept without warnings by trusting your own private Certificate Authority (CA).

Important notes
- Self-signed/Private CA is great for home labs and internal networks, but do not expose it publicly unless you know what you are doing.
- Keep your CA private key extremely secure. Anyone with it can mint trusted certs for any host in your domain.

Contents
- Prerequisites
- What you will create
- Create a private Root CA
- Create a server certificate signed by your CA
- Prepare files for Traefik
- Point Traefik to the certificate

## Prerequisites
- OpenSSL installed on an admin machine (macOS, Linux, or WSL). On macOS and most Linux distros it is available by default.
- Your internal domain configured in NASsible (e.g. `ansible_nas_domain`), for example `your.domain`.
- The set of hostnames you want to protect, e.g.:
  - `your.domain`
  - `*.your.domain` (wildcard)

## What you will create
- Private Root CA key and certificate: `ca.key`, `ca.crt`
- Traefik server key and certificate signed by your CA: `traefik.key`, `traefik.crt`
- An optional certificate chain file: `fullchain.crt` (Traefik only needs `traefik.crt` and `traefik.key`, but the chain can be useful elsewhere.)

## 1) Create a private Root CA
Work in a temporary directory on your admin machine.

Generate the CA private key (PEM, 4096-bit RSA):
```bash
openssl genrsa -out ca.key 4096
```

Create the CA certificate (valid 10 years = 3650 days):
```bash
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 \
  -subj "/C=HU/ST=Budapest/L=Budapest/O=HomeLab/OU=IT/CN=HomeLab Root CA" \
  -out ca.crt
```

Security tip: Store `ca.key` offline or in a secure password manager/vault. Do NOT put it in your NAS or repository.

## 2) Create a server certificate signed by your CA
Create a private key for Traefik:
```bash
openssl genrsa -out traefik.key 2048
```

Create an OpenSSL config for Subject Alternative Names (SAN). Create a file named `san.cnf` with the following content and adjust the domain(s):
```ini
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[ req_distinguished_name ]
CN =  *.your.domain

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = *.your.domain
```

Create a Certificate Signing Request (CSR):
```bash
openssl req -new -key traefik.key -out traefik.csr -config san.cnf
```

Sign the CSR with your Root CA:
```bash
openssl x509 -req -in traefik.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out traefik.crt -days 3649 -sha256 -extfile san.cnf -extensions v3_req
```

(Optional) Create a full chain file (Root CA + server cert). This is not required by Traefik for the default store, but is sometimes useful:
```bash

```

Verify the certificate:
```bash
openssl x509 -in traefik.crt -noout -text | grep -E "Subject:|DNS:|Issuer:|Not After"
```

## 3) Prepare files for Traefik
Copy `traefik.crt` and `traefik.key` to the host path that Traefik mounts as `/certs`. Recreate traefik container if needed.