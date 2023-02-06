# Intranet services

The lab runs some intranet services for use by hosts that are part of the lab.
This page documents them.

Unless specified otherwise, **all IP addresses are considered implementation detail** and must not be relied upon to not change.

## Nameserver: `10.42.0.3`

The nameserver at `10.42.0.3` (aka `ns1.rudn.lab`) is the **authoritative nameserver** for the `rudn.lab` zone.
All lab hosts are part of this zone.
Users of the lab should contact the NS team to apply for subdomain assignments.

At present, this also acts as a recursive resolver, deferring to `1.1.1.1` for other zones.
*This behaviour may change in the future.*

**The IP address of this service is stable.**

## Certificate authority: `ca.rudn.lab`

This host runs a [Smallstep CA](https://smallstep.com/) that serves as the root of trust for the lab's TLS communications.

Lab users can use the included ACME provisioner to create certificates for their servers.
To do this, you must first have a domain name assigned to your IP.
These certificates have an expiration period of 24 hours, so automated renewal is required.
See [the ACME guide (TODO)](..) to learn how to do this.


The root certificate's fingerprint is `66bd0ed46a5ff69b611395837b3fdf22e8f7da0cf46bed621b3db6e6a0a63a06`, and it can be found in
[`root_ca.crt`](root_ca.crt).
New hosts provisioned for the lab should include this certificate in their trust chain to access other hosts.

The CA admins have made reasonable precautions that this CA cannot be used to sign certificates for domains other than `rudn.lab`.
However, this might be insufficient.
For this reason, it is recommended that you **do not add this certificate to your personal device trust chain**,
because if this gets leaked, then whoever gains access to it would be able to pwn all your TLS connections.
In fact, you should not even trust the admins not to do this!

Instead, consider verifying the certificate manually. For example, with `curl`, you can do this:

```bash
$ # Assume the cert is already downloaded
$ curl --cacert root_ca.crt https://ca.rudn.lab
```

Consult your favorite browser and programming language documentation for info on how to do the same there.

## Package cache: `apt-cache.rudn.lab`

This host runs [Apt-Cacher-Ng](https://wiki.debian.org/AptCacherNg).
You can use this as an HTTP proxy for your package manager in order to speed up your package update downloads.
If you'd like to use this on a Debian-based system, create a file `/etc/apt/apt.conf.d/00-apt-cache` with the contents:

```
Acquire::http::Proxy "http://apt-cache.rudn.lab:80";
```

At present, it uses the default configuration, which only caches `.deb` files.
It is possible to allow more file types to be cached; contact the admin team to coordinate this.


## Information page: `info.rudn.lab`

This hosts a web server with information about the lab.
It also uses the certificate authority, so you can test whether you trust it.
