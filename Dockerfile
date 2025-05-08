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
        python39 \
        python39-pip \
        python39-devel \
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
    && pip install ansible \
    && ansible-galaxy collection install community.general

## Extra Configs
ENV K9S_VERSION=v0.32.4
RUN echo "alias ll='ls -la'" >> /root/.bashrc \
    && mkdir /root/projects \
    && curl -sSL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" \
    | tar xz && mv k9s /usr/local/bin/k9s && chmod +x /usr/local/bin/k9s

# Set a working directory
WORKDIR /root/projects

# Default command
CMD ["/bin/bash"]