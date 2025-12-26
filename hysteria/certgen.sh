#!/bin/bash

ip="ip_address" # меняем ip

mkdir -p ssl

openssl genrsa -out ./ssl/hysteria.ca.key 2048

openssl req -new -x509 -days 3650 -key ./ssl/hysteria.ca.key -subj "/CN=Hysteria Root CA" -out ./ssl/hysteria.ca.crt

openssl req -newkey rsa:2048 -nodes -keyout ./ssl/hysteria.server.key -subj "/CN=$ip" -out ./ssl/hysteria.server.csr

openssl x509 -req -extfile <(printf "subjectAltName=IP:$ip") -days 3650 -in ./ssl/hysteria.server.csr -CA ./ssl/hysteria.ca.crt -CAkey ./ssl/hysteria.ca.key -CAcreateserial -out ./ssl/hysteria.server.crt

openssl x509 -noout -fingerprint -sha256 -in ./ssl/hysteria.server.crt
openssl x509 -noout -fingerprint -sha256 -in ./ssl/hysteria.server.crt > sha256.txt
