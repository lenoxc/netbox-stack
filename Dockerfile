FROM netboxcommunity/netbox:latest

USER root

# 1. Install pip and dependencies
RUN apt-get update && apt-get install -y wget gcc
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN /opt/netbox/venv/bin/python get-pip.py

# 2. Install the plugin
RUN /opt/netbox/venv/bin/pip install netbox-proxbox

# 3. Bake the configuration directly into the image to bypass Portainer mount errors
RUN mkdir -p /etc/netbox/config && echo "PLUGINS = ['netbox_proxbox']" > /etc/netbox/config/plugins.py

USER netbox
