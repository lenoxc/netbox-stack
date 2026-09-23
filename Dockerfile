FROM netboxcommunity/netbox:v4.7.0

USER root

# 1. Install system build dependencies
RUN apt-get update && apt-get install -y curl wget gcc build-essential libffi-dev libssl-dev python3-dev pkg-config

# 2. Install the latest official Rust compiler directly
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# 3. Update core Python build tools
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN /opt/netbox/venv/bin/python get-pip.py
RUN /opt/netbox/venv/bin/pip install --upgrade setuptools wheel

# 4. Install ONLY Proxbox for now to bypass the build crash
RUN /opt/netbox/venv/bin/pip install netbox-proxbox

# 5. Bake the configuration directly into the image
RUN mkdir -p /etc/netbox/config && echo "PLUGINS = ['netbox_proxbox', 'netbox_openbao']" > /etc/netbox/config/plugins.py

USER netbox
