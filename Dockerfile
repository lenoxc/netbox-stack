FROM netboxcommunity/netbox:latest
RUN python3 -m pip install netbox-proxbox || python3 -m ensurepip --upgrade && python3 -m pip install netbox-proxbox
