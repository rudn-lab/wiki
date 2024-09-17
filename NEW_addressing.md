Since moving to the uni's server room, our IP addressing has changes significantly.

# To uni network

In the uni network, we've received our IP address from the DHCP. However, the network admin is going to give us static IPs there: when that happens, it might be easier to set up our own servers as static IP too.

Currently the IPs are:

- Cepheus: 10.131.17.12
- Cepheus iLO: 10.131.17.11
- Ursa-Major: 10.131.17.23
- Ursa-Minor: 10.131.17.13
- Ursa-Minor iLO: 10.131.17.14

# Internal

We've connected the servers together with wires directly from one NIC to another. This is to provide a high-speed and reliable network between our servers. The connections are as follows:

- Ursa-Minor `enp7s1f1` 172.16.42.1 -- 172.16.42.2 `enp4s0f1` Cepheus
- Ursa-Minor `enp7s1f0` 172.16.42.1 -- 172.16.42.3 `enp0s9` Ursa-Major

## NICs

Here are the servers' network interfaces:

## Cepheus

- *9c:8e:99:fa:ee:8a*
- 9c:8e:99:fa:ee:8c
- 9c:8e:99:fa:ee:8e
- 9c:8e:99:fa:ee:90
- 9c:8e:99:fa:ee:92 (iLO port)

## Ursa-Major

- 00:a0:d1:e7:9f:cc
- 00:a0:d1:e7:9f:cd

## Ursa-Minor

- *00:18:71:e5:55:96*
- 00:18:71:e5:55:95
- 00:04:23:a8:a6:12
- 00:04:23:a8:a6:13
- 00:18:71:e7:63:a8 (iLO port)