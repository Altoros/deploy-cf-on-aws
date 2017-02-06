#!/bin/bash
set -xe

export TF_VAR_access_key=$aws_id
export TF_VAR_secret_key=$aws_key
export TF_VAR_pub_key=`pwd`/deploy-cf-on-aws/jumpbox.pub
export TF_VAR_pvt_key=`pwd`/deploy-cf-on-aws/jumpbox.pem
#export TF_VAR_region=$region
#export TF_VAR_ssl_cert=$ssl_cert
#export TF_VAR_system_domain=$system_domain
#export TF_VAR_cf_release=$cf_release
#export TF_VAR_cf_secret=$cf_secret
#export TF_VAR_rds_password=$rds_password
#export TF_VAR_route53_zoneid=$route53_zoneid

cd task-temp/tf-aws
make destroy-ci
