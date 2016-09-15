#!/bin/bash
set -xe

apt-get update
apt-get install -qq -y wget
apt-get install -qq -yy build-essential git unzip ruby-bundler zlib1g-dev libsqlite3-dev libssl-dev zlibc zlib1g-dev openssl libxslt-dev libxml2-dev libreadline6 libreadline6-dev ruby ruby-dev libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev

wget -c https://s3.amazonaws.com/bosh-init-artifacts/bosh-init-0.0.96-linux-amd64
chmod +x bosh-init-0.0.96-linux-amd64
mv bosh-init-0.0.96-linux-amd64 /usr/local/bin/bosh-init

wget -c https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64.zip
unzip spiff_linux_amd64.zip
rm spiff_linux_amd64.zip
mv spiff /usr/local/bin/

wget -c https://releases.hashicorp.com/terraform/0.7.3/terraform_0.7.3_linux_amd64.zip
unzip terraform_0.7.3_linux_amd64.zip
rm terraform_0.7.3_linux_amd64.zip
mv terraform* /usr/local/bin/

#check for versions
bosh-init -v
spiff -v
terraform -v

export pub_key=$pub_key
export pvt_key=$pvt_key

printenv $PUB_KEY > ~/.ssh/id_rsa_tf.pub
printenv $PVT_KEY > ~/.ssh/id_rsa_tf

export TF_VAR_access_key=$aws_id
export TF_VAR_secret_key=$aws_key
export TF_VAR_region=$region
export TF_VAR_pub_key="~/.ssh/id_rsa_tf.pub"
export TF_VAR_pvt_key="~/.ssh/id_rsa_tf"

cd cf-workspace
make apply
