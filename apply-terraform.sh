#!/bin/bash
set -xe

apt-get update
apt-get install -y wget
apt-get install -y build-essential git unzip ruby-bundler zlib1g-dev libsqlite3-dev libssl-dev zlibc zlib1g-dev openssl libxslt-dev libxml2-dev libreadline6 libreadline6-dev ruby ruby-dev libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev

wget -c https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_linux_amd64.zip
unzip terraform_0.7.13_linux_amd64.zip
rm terraform_0.7.13_linux_amd64.zip
mv terraform* /usr/local/bin/

#check for versions
terraform -v

# export pub_key=$pub_key
# export pvt_key=$pvt_key
#
# printenv $PUB_KEY > ~/.ssh/id_rsa_tf.pub
# printenv $PVT_KEY > ~/.ssh/id_rsa_tf

#echo $pub_key > id_rsa_tf.pub
#echo $pvt_key > id_rsa_tf


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

echo ${altorosci_pvt_key} > /tmp/altorosci.pem
export TF_VAR_altoros-ci_pvt_key="/tmp/altorosci.pem"

cd cf-workspace/terraform/aws
make apply
sleep 60
make destroy
