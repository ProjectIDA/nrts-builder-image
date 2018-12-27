# build-nrts-builder
Build docker image for compiling NRTS binaries

## Pipeline

### Build machine image to run Packer

1. Spin up a CircleCI machine image (Ubuntu)
2. install packer (**.circle/config.yml**)
3. install ansible (**.circle/config.yml**)
4. Validate packer build config file **nrtsbuild-ami-builder.json**

### Run Packer to build and provision docker image based on Amazon Linux 2 AMI (**nrtsbuild-ami-builder.json**)

5. Use **dicker** build based on **amazonlinux:2** image
6. Use **ansible** to provision (**nrts_build-prov.yml**)

### Run Packer post-processors

7. _docker-tag_ with for dockerhub repo: **projectida/nrts-builder**
8. _docker-push_ to save image on dockerhub.