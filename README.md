# nrts-builder-image

Build docker image used to compile NRTS binaries

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