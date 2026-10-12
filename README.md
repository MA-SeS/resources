Public resources for the course "MA Secure Embedded Systems"

This is the contents needed for the various labs:

```
labs/
├── .devcontainer
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   ├── docker-compose.build.yml
│   ├── buildroot
│   │   └── devcontainer.json
│   └── servers
│       └── devcontainer.json
└── resources
    └── utilities
        └── sd_copy.sh
```

To open the full `labs` workspace in VS Code, open the `labs` folder and run **Dev Containers: Reopen in Container** from the Command Palette. VS Code first builds both images using `docker-compose.build.yml`, then starts both services from `docker-compose.yml` and attaches to the selected service (`toolchain` by default). Both services share `/workspace` and the named Buildroot, TFTP, and NFS volumes.

## Network topology

```mermaid
flowchart LR
        client[Lab device or network client] -->|Host LAN address| host[Docker host]
        subgraph compose[Docker Compose default bridge network]
                toolchain[toolchain container]
                servers[servers container<br/>TFTP and NFSv4]
                tftp[(tftpd-data volume)]
                nfs[(nfs-rootfs volume)]
                buildroot[(buildroot-data volume)]
                toolchain ---|/workspace/tftpd| tftp
                servers ---|/workspace/tftpd| tftp
                toolchain ---|/workspace/nfs-rootfs| nfs
                servers ---|/workspace/nfs-rootfs| nfs
                toolchain ---|/workspace/buildroot| buildroot
                servers ---|/workspace/buildroot| buildroot
        end
        toolchain -->|TFTP via service name servers| servers
        host -->|UDP 69, TCP 2049| servers
```

The `labs` folder is bind-mounted at `/workspace` in both containers. The named volumes overlay `/workspace/buildroot`, `/workspace/tftpd`, and `/workspace/nfs-rootfs`, so files written to those paths in `toolchain` are immediately visible to `servers`. The server ports are published on the Docker host: TFTP uses UDP 69 and NFSv4 uses TCP 2049. Use the Docker host's LAN address for another machine; from a Compose container, use the service name `servers`.

## Serving files

### TFTP

Copy files from `toolchain` into `/workspace/tftpd`; this directory is the TFTP root. For example:

```sh
cp /workspace/buildroot/output/images/<file> /workspace/tftpd/
```

Clients download by filename relative to that root. For example, with curl:

```sh
curl -o <local-file> tftp://<server-address>/<file>
```

Use `servers` as `<server-address>` from another Compose container, or the Docker host's LAN address from a lab device.

### NFS

Copy files from `toolchain` into `/workspace/nfs-rootfs`. This shared volume is exported by NFSv4 at pseudo-path `/`. From a Linux client, mount it with:

```sh
sudo mkdir -p /mnt/nfs-rootfs
sudo mount -t nfs4 -o vers=4.1 <server-address>:/ /mnt/nfs-rootfs
```

The current Ganesha configuration grants read/write access only to `192.168.1.2`, `127.0.0.1`, and `::1`. If the client uses a different IP, add that client IP or its intended subnet to `CLIENTS` in `.devcontainer/servers/ctxt/ganesha.conf`, then rebuild/reopen the Dev Container so the updated config is copied into the server image. NFS uses `No_Root_Squash`, so only grant access to trusted clients.

**Important note**: in order for the copy of the compiled image to work, one needs to have a `sd_folder` under `/workspace` for it to work. If one chooses a different structure, the person needs to adapt the `sd_copy.sh` script.