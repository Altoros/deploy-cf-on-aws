#!/bin/bash
set -xe

apt-get update
apt-get install -y wget

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
#export TF_VAR_pub_key=`pwd`/deploy-cf-on-aws/jumpbox.pub
#export TF_VAR_pvt_key=`pwd`/deploy-cf-on-aws/jumpbox.pem

cd cf-workspace/terraform/aws
make apply
