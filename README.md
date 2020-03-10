# nrts-builder-image

Use circleci.com to build a docker image based on AWS AMI Linux Version 2. 

## Description

Using .circleci/config.yml, CircleCI will spin up generic Ubuntu Linux VM used to build an **amazonlinux:2** docker image customized for building the NRTS data acqusition software stack. CicrleCI will install in this VM zip, packer and ansible used to create the final Docker AMI image. CircleCI then runs pack (with packer file __build-nrts-builder-image.json__) which in turn uses ansible (with ansible playbook __prov-nrts-builder-image.yml__) to provision the AMI Docker image. Packer then pushes the provisioned image to Docker.io.

## Steps

### Build machine image to run Packer

1. Spin up a CircleCI machine image (Ubuntu)
2. install packer (**.circle/config.yml**)
3. install ansible (**.circle/config.yml**)

### Run Packer to build and provision docker image based on Amazon Linux 2 AMI (**nrtsbuild-ami-builder.json**)

4. Validate packer build config file **build-nrts-builder-image.json**
5. Run packer build config file **build-nrts-builder-image.json**
>
> - Use **docker** build based on **amazonlinux:2** image
> - Use **ansible** to provision (**prov-nrts-builder-image.yml**)
>
### Run Packer post-processors

6. _docker-tag_ with timestamp for dockerhub repo: **projectida/nrts-builder-image**
7. _docker-push_ to save image on dockerhub.
