#!/usr/bin/env bash
 
cd "$(dirname "$0")/.."     
 
MY_IP=$(curl -s https://checkip.amazonaws.com)
 
cd bootstrap
terraform init
terraform apply -auto-approve
 
cd ../terraform
terraform init
terraform apply -auto-approve -var="allowed_ssh_cidrs=[\"$MY_IP/32\"]"
 
cd ..
bash scripts/gen_inventory.sh
 
cd ansible
ansible-playbook -i inventory/hosts.yml playbook/site.yml
