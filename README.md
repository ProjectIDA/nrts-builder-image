# nrts-builder-image

Use circleci.com to build a docker image based on AWS AMI Linux Version 2. 

## Description

Using .circleci/config.yml, CircleCI will spin up docker container used to run packer to build an **amazonlinux:2** AMI customized for running the NRTS data acqusition software stack. In this docker container CicrleCI will install **packer** and ansible. CircleCI then runs packer (using packer file __build-nrts-builder-image.json__) which in turn uses ansible (with ansible playbook __prov-nrts-builder-image.yml__) to provision the AMI image. Packer then pushes the provisioned image to AWS regions **us0-west-2** and **us-east-2** in the Project IDA AWS account.

The resulting custom AMI is named *ida-nrts-hub*

## Steps

### CircleCI: Build docker image to run Packer

1. Spin up a CircleCI machine image (Ubuntu)
2. install packer (**.circle/config.yml**)
3. install ansible (**.circle/config.yml**)

### Run Packer to build and provision a custom AWS AMI image based on the Amazon Linux 2 AMI

4. Validate packer build config file *build-nrts-hub-ec2-ami.json*
5. Run packer build config file *build-nrts-hub-ec2-ami.json*. Packer spins up a base Amazon Linux 2 AMI instance and then runs ansible to provision it for use as an NRTS HUB.

