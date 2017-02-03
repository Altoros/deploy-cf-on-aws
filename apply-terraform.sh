#!/bin/bash
set -xe

export TF_VAR_access_key=$aws_id
export TF_VAR_secret_key=$aws_key
export TF_VAR_pub_key=`pwd`/deploy-cf-on-aws/jumpbox.pub
export TF_VAR_pvt_key=`pwd`/deploy-cf-on-aws/jumpbox.pem
echo "region = \"$region\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "ssl_cert = \"$ssl_cert\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "system_domain = \"$system_domain\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "cf_release = \"$cf_release\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "cf_secret = \"$cf_secret\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "rds_password = \"$rds_password\"" >> cf-workspace/terraform/aws/terraform.tfvars
echo "route53_zoneid = \"$route53_zoneid\"" >> cf-workspace/terraform/aws/terraform.tfvars

echo "altorosci_pvt_key = <<EOF" >> cf-workspace/terraform/aws/terraform.tfvars
echo "${altorosci_pvt_key}" >> cf-workspace/terraform/aws/terraform.tfvars
echo "EOF" >> cf-workspace/terraform/aws/terraform.tfvars

cd cf-workspace/terraform/aws
make apply

# copy tf state to temp dir
mkdir -p ../../../task-temp/tf-aws/
cp -vr * ../../../task-temp/tf-aws/
