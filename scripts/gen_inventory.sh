#!/usr/bin/env bash
set -euo pipefail
cd terraform/

# check output is available
if ! terraform output -json &> /dev/null; then
    echo "Error: No Terraform outputs found. Please run 'terraform apply' first." >&2
    exit 1
fi


APP_PUBLIC_IP=$(terraform output -raw app_public_ip)
APP_PRIVATE_IP=$(terraform output -raw app_private_ip)
DB_PUBLIC_IP=$(terraform output -raw db_public_ip)
DB_PRIVATE_IP=$(terraform output -raw db_private_ip)
SSH_USER=$(terraform output -raw ssh_user)

cd ..
mkdir -p ansible/inventory

echo "create hosts.yaml file..."
cat << EOF > ansible/inventory/hosts.yml
all:
  hosts:
    app_server:
      ansible_host: ${APP_PUBLIC_IP}
      ansible_user: ${SSH_USER}
      private_ip: ${APP_PRIVATE_IP}
      db_private_ip: ${DB_PRIVATE_IP}
    
    db_server:
      ansible_host: ${DB_PUBLIC_IP}
      ansible_user: ${SSH_USER}
      private_ip: ${DB_PRIVATE_IP}

  children:
    web:
      hosts:
        app_server:
    database:
      hosts:
        db_server:
EOF

echo "Successfully generated ansible/inventory/hosts.yml with latest Terraform IPs!"
