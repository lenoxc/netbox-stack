FROM netboxcommunity/netbox:latest

USER root

# 1. Install wget (to download pip) and gcc (in case the plugin needs compilation)
RUN apt-get update && apt-get install -y wget gcc

# 2. Download the official pip bootstrapper
RUN wget https://bootstrap.pypa.io/get-pip.py

# 3. Force-install pip back into the NetBox isolated environment
RUN /opt/netbox/venv/bin/python get-pip.py

# 4. Install the Proxbox plugin using the newly installed pip
RUN /opt/netbox/venv/bin/pip install netbox-proxbox

USER netbox
