# Addressing scheme

The lab occupies the network segment `10.42.0.0/16`.
It is distributed as follows:

- `10.42.0.1` is reserved for the main router that provides internet access.
- `10.42.0.2` is reserved for the first Proxmox virtualization server.
- Other addresses in `10.42.0.0/24` are assigned to common intranet services. Those are documented in [`services.md`](services.md)
- The remainder `10.42.0.0/17` can be assigned to lab users on request.
- `10.42.128.0/17` is the DHCP range. Hosts that are not part of the lab (for example visiting laptops) are assigned these addresses.

