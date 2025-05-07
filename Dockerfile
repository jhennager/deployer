# Use Red Hat UBI 8 standard base image
FROM almalinux:8

## Add Terraform Repo
RUN dnf -y install yum-utils \
    && yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# Update and install packages
RUN dnf -y update && \
    dnf -y install \
        vim \
        curl \
        iproute \
        net-tools \
        procps \
        python38 \
        python38-pip \
        python38-devel \
        gcc \
        make \
        git \
        iputils \
        bind-utils \
        terraform  \     
        && dnf clean all

## Install ansible using pip
RUN pip3 install --upgrade pip \
    && pip install wheel \
    && pip install ansible

## Extra Configs
RUN echo "alias ll='ls -la'" >> /root/.bashrc \
    && mkdir /root/projects

# Set a working directory
WORKDIR /root/projects

# Default command
CMD ["/bin/bash"]