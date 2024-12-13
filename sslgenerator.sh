#!/bin/bash

##
## Source:
##  https://akshitb.medium.com/how-to-run-https-on-localhost-a-step-by-step-guide-c61fde893771
##

echo "Creating SSL certs"

openssl genrsa -out root.key 2048
# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -new -nodes -key root.key -sha256 -days 365 -out root.crt -subj "/C=TEST/ST=TEST/L=AR/O=TEST/OU=TEST/CN=*.test.dev/emailAddress=test@example.com"

echo "CA's self-signed certificate"
openssl genrsa -out server.key 2048

# 2. Generate web server's private key and certificate signing request (CSR)
openssl req -new -key server.key -out server.csr -subj "/C=TEST/ST=TEST/L=TEST/O=TEST/OU=TEST/CN=*.test.dev/emailAddress=test@example.com"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server.csr -CA root.crt -CAkey root.key -CAcreateserial -out server.crt -days 365 -sha256
