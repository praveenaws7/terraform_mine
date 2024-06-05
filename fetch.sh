
# Fetch the public IPs from Terraform output
public_ips=$(terraform output -json public_ips | jq -r '.[]')

# Convert the public IPs to an array
public_ips_array=($public_ips)

# Fetch the public IPs from the array
IP1=${public_ips_array[0]}
IP2=${public_ips_array[1]}
IP3=${public_ips_array[2]}

# Read the proxy configuration from the file
proxy_config=$(cat /mnt/c/Users/QC/Desktop/Project_Terraform/terraform_mine/haproxy.txt)

# Replace the placeholders in the proxy configuration with the actual IPs
proxy_config=${proxy_config//\$IP1/$IP1}
proxy_config=${proxy_config//\$IP2/$IP2}
proxy_config=${proxy_config//\$IP3/$IP3}

# Write the updated proxy configuration to the file
echo "$proxy_config" > haproxy.cfg
