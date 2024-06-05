#!/bin/bash

# Fetch the public IPs from Terraform output
public_ips=$(terraform output -json public_ips | jq -r '.[]')

# Convert the public IPs to an array
public_ips_array=($public_ips)

# Fetch the public IPs from the array
IP1=${public_ips_array[0]}
IP2=${public_ips_array[1]}
IP3=${public_ips_array[2]}

# Define the haproxy configuration
cat << EOF >> filx.txt
frontend haproxy
   bind *:80
   default_backend haproxy
backend haproxy
   balance roundrobin
   server server-1 $IP1
   server server-2 $IP2
   server server-3 $IP3
EOF
