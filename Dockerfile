FROM ubuntu:16.04

USER root

#labeling
LABEL maintainer="netiotedge@hilscher.com" \ 
      version="V1.0.0.5" \
      description="Desktop (DVI) for NIOT-E-TIJCX-GB-RE"

#version
ENV HILSCHERNETIOTEDGE_DESKTOP_VERSION 1.0.0.5

#update first
RUN apt-get update 

#create "testuser"
RUN useradd --create-home --shell /bin/bash testuser \
    && echo 'testuser:mypassword' | chpasswd \
    && adduser testuser tty \
    && adduser testuser video \
    && apt-get install -y sudo \
    && adduser testuser sudo \
    && echo "testuser ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/testuser \
    && chmod 0440 /etc/sudoers.d/testuser

#install xserver, desktop, login manager, web browser    
RUN apt-get -y install --no-install-recommends xserver-xorg \
    && apt-get -y install --no-install-recommends xserver-xorg-legacy \
    && apt-get -y install --no-install-recommends xinit \
    && apt-get -y install xfce4 xfce4-terminal \
    && apt-get -y install chromium-browser \
    && mkdir /etc/X11/xorg.conf.d
  
#copy script to move input devices and events to X11
COPY "./files-to-copy-to-image/event.sh" "/"

#allow all users to use X11
RUN sed -i -e 's/allowed_users=console/allowed_users=anybody/g' /etc/X11/Xwrapper.config \
    && echo "needs_root_rights=yes">>/etc/X11/Xwrapper.config

RUN chmod +x /event.sh \
    && chmod u+s /usr/bin/Xorg \
    && chown -c testuser /etc/X11/xorg.conf.d

USER testuser

#set the entrypoint
ENTRYPOINT ["/event.sh"]
