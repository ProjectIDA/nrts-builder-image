# build-nrts-builder
Build docker image for compiling NRTS binaries

## Pipeline

### Build machine image to run Packer

1. Spin up a CircleCI machine image and install packer (**.circle/config.yml**)
2. Validate packer build config file **nrtsbuild-ami-builder.json**

### Run Packer to build and provision docker image based on Amazon Linux 2 AMI (**nrtsbuild-ami-builder.json**)

3. Use **dicker** build based on **amazonlinux:2** image
4. Use **ansible** to provision (**nrts_build-prov.yml**)

### Run Packer post-processors

5. _docker-tag_ with for dockerhub repo: **projectida/nrts-builder**
6. _docker-push_ to save image on dockerhub.