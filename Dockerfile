FROM netboxcommunity/netbox:v4.7.0

USER root

# 1. Install pip and cryptographic build dependencies
RUN apt-get update && apt-get install -y wget gcc build-essential libffi-dev libssl-dev python3-dev pkg-config cargo
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN /opt/netbox/venv/bin/python get-pip.py

# 2. Install the plugins
RUN /opt/netbox/venv/bin/pip install netbox-proxbox netbox-openbao

# 3. Bake the configuration directly into the image
RUN mkdir -p /etc/netbox/config && echo "PLUGINS = ['netbox_proxbox', 'netbox_openbao']" > /etc/netbox/config/plugins.py

USER netbox
