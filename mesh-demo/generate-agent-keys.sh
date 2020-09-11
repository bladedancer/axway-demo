#!/bin/bash

echo =======================
echo Generating SDA Key
echo =======================
openssl genpkey -algorithm RSA -out central/sda_private_key.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -pubout -in central/sda_private_key.pem -out central/sda_public_key.der -outform der && base64 central/sda_public_key.der > central/sda_public_key

echo =======================
echo Generating CSA Key
echo =======================
openssl genpkey -algorithm RSA -out central/csa_private_key.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -pubout -in central/csa_private_key.pem -out central/csa_public_key.der -outform der && base64 central/csa_public_key.der > central/csa_public_key
