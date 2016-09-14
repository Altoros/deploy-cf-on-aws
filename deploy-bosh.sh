#!/bin/bash
set -e

# Set Photon Specific Deployment Object IDs in BOSH Manifest
cp deploy-photon/manifests/bosh/$bosh_manifest /tmp/bosh.yml

CPI_RELEASE_REGEX=$(echo $CPI_RELEASE | sed 's|/|\\\/|g')
BOSH_DEPLOYMENT_NETWORK_SUBNET_REGEX=$(echo $bosh_deployment_network_subnet | sed 's|/|\\\/|g' | sed 's|\.|\\\.|g')

perl -pi -e "s/PHOTON_PROJ_ID/$PHOTON_PROJ_ID/g" /tmp/bosh.yml
perl -pi -e "s/PHOTON_CTRL_IP/$PHOTON_CTRL_IP/g" /tmp/bosh.yml
perl -pi -e "s/PHOTON_USER/$photon_user/g" /tmp/bosh.yml
perl -pi -e "s/PHOTON_PASSWD/$photon_passwd/g" /tmp/bosh.yml
perl -pi -e "s/PHOTON_IGNORE_CERT/$photon_ignore_cert/g" /tmp/bosh.yml
perl -pi -e "s/PHOTON_TENANT/$photon_tenant/g" /tmp/bosh.yml
perl -pi -e "s/CPI_SHA1/$CPI_SHA1/g" /tmp/bosh.yml
perl -pi -e "s/CPI_RELEASE/$CPI_RELEASE_REGEX/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_NETWORK_ID/$BOSH_DEPLOYMENT_NETWORK_ID/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_NETWORK_SUBNET/$BOSH_DEPLOYMENT_NETWORK_SUBNET_REGEX/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_NETWORK_GW/$bosh_deployment_network_gw/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_NETWORK_DNS/$bosh_deployment_network_dns/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_NETWORK_IP/$bosh_deployment_network_ip/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_USER/$bosh_deployment_user/g" /tmp/bosh.yml
perl -pi -e "s/BOSH_DEPLOYMENT_PASSWD/$bosh_deployment_passwd/g" /tmp/bosh.yml

cat /tmp/bosh.yml

# Deploy BOSH
echo "Deploying BOSH ..."
bosh-init deploy /tmp/bosh.yml

# Target Bosh and test Status Reply
echo "sleep 3 minutes while BOSH starts..."
sleep 180
#BOSH_TARGET=$(cat /tmp/bosh.yml | shyaml get-values jobs.0.networks.0.static_ips)
#BOSH_LOGIN=$(cat /tmp/bosh.yml | shyaml get-value jobs.0.properties.director.user_management.local.users.0.name)
#BOSH_PASSWD=$(cat /tmp/bosh.yml | shyaml get-value jobs.0.properties.director.user_management.local.users.0.password)
bosh -n target https://${bosh_deployment_network_ip}
bosh -n login ${bosh_deployment_user} ${bosh_deployment_passwd}
bosh status
