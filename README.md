### Required Environmental Variables
- `HTTP_PORT` - 80
- `HTTPS_PORT` - 443
- `PROXY_ADDRESS` - localhost
- `PROXY_PORT` - 8080
- `DOMAINS` - space separated domains, i.e. "example.com www.example.com". Wildcards currently not supported as they require setting DNS records which is outside the scope of this tool.
- `KEY_LENGTH` - 4096
- `DRY_RUN` - use the letsencrypt staging servers
- `RESOLVER` - resolver for nginx to use. Defaults to `127.0.0.11`. see [docker docs](https://docs.docker.com/v17.09/engine/userguide/networking/configure-dns/) 


### exposed volumes
Certs are placed in /etc/ssl/acme, so it's a good idea to mount that as a volume.
