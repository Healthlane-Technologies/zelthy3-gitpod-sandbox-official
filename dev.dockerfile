FROM zelthy3:latest

ARG UID
ARG GID

# Update the package list, install sudo, create a non-root user, and grant password-less sudo permissions
RUN apt update && \
    apt install -y sudo && \
    addgroup --gid $GID gitpod && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" gitpod && \
    echo 'gitpod ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Set the non-root user as the default user
USER gitpod

COPY init.sh /zelthy/
WORKDIR /zelthy/

RUN sudo chown -R gitpod:gitpod /zelthy/

RUN chmod +x /zelthy/init.sh