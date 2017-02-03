#!/bin/bash
set -xe

export TF_VAR_pub_key=`pwd`/deploy-cf-on-aws/jumpbox.pub
export TF_VAR_pvt_key=`pwd`/deploy-cf-on-aws/jumpbox.pem

cd task-temp/tf-aws
make run-smoke
