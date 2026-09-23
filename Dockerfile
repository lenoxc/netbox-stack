FROM netboxcommunity/netbox:latest

USER root
# Ensure pip is available and install the plugin into the NetBox environment
RUN python3 -m venv /opt/netbox/venv || true \
    && /opt/netbox/venv/bin/python -m ensurepip \
    && /opt/netbox/venv/bin/pip install netbox-proxbox

USER netbox
