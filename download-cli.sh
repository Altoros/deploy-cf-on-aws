#!/bin/bash
set -e

wget -c https://s3.amazonaws.com/bosh-init-artifacts/bosh-init-0.0.96-linux-amd64
chmod +x bosh-init-0.0.96-linux-amd64
sudo mv bosh-init-0.0.96-linux-amd64 /usr/local/bin/bosh-init

wget -c https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64.zip
unzip spiff_linux_amd64.zip
rm spiff_linux_amd64.zip
sudo mv spiff /usr/local/bin/

wget -c https://releases.hashicorp.com/terraform/0.7.3/terraform_0.7.3_linux_amd64.zip
unzip terraform_0.7.3_linux_amd64.zip
rm terraform_0.7.3_linux_amd64.zip
sudo mv terraform* /usr/local/bin/
