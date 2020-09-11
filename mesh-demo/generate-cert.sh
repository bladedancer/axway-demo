#!/bin/bash

DOMAIN=${1:-mesh.example.com}

echo =======================
echo Generating Cert
echo =======================
openssl genrsa -out central/server.key 2048
openssl rsa -in central/server.key -out central/server.key
openssl req -sha256 -new -key central/server.key -out central/server.csr -subj "/CN=${DOMAIN}"
openssl x509 -req -sha256 -days 365 -in central/server.csr -signkey central/server.key -out central/server.crt

