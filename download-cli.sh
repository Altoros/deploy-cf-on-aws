#!/bin/bash
set -xe

apt-get update
apt-get install wget
apt-get install -y build-essential git unzip ruby-bundler zlib1g-dev libsqlite3-dev libssl-dev zlibc zlib1g-dev openssl libxslt-dev libxml2-dev libreadline6 libreadline6-dev ruby ruby-dev libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev

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
