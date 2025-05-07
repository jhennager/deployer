# Use Red Hat UBI 8 standard base image
FROM registry.access.redhat.com/ubi8/ubi

# Update and install packages
RUN dnf -y update && \
    dnf -y install \
        vim \
        curl \
        iproute \
        net-tools \
        procps \
        && dnf clean all

# Copy custom configuration files (optional)
# COPY ./my-config.conf /etc/myapp/config.conf

# Set a working directory
WORKDIR /root

# Default command
CMD ["/bin/bash"]