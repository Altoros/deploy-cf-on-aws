#!/bin/bash
set -xe

apt-get update
apt-get install -y wget git unzip make

wget -c https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_linux_amd64.zip
unzip terraform_0.7.13_linux_amd64.zip
rm terraform_0.7.13_linux_amd64.zip
mv terraform* /usr/local/bin/

#check for versions
terraform -v

export TF_VAR_access_key=$aws_id
export TF_VAR_secret_key=$aws_key
export TF_VAR_region=$region
export TF_VAR_pub_key=`pwd`/deploy-cf-on-aws/jumpbox.pub
export TF_VAR_pvt_key=`pwd`/deploy-cf-on-aws/jumpbox.pem
export TF_VAR_ssl_cert=$ssl_cert
export TF_VAR_system_domain=$system_domain
export TF_VAR_cf_release=$cf_release
export TF_VAR_cf_secret=$cf_secret
export TF_VAR_rds_password=$rds_password

echo "altorosci_pvt_key = <<EOF" >> cf-workspace/terraform/aws/terraform.tfvars
echo "${altorosci_pvt_key}" >> cf-workspace/terraform/aws/terraform.tfvars
echo "EOF" >> cf-workspace/terraform/aws/terraform.tfvars

cd cf-workspace/terraform/aws
make apply
sleep 60
make destroy-ci
