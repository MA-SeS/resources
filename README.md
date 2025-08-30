Public resources for the course "MA Secure Embedded Systems"

This is the contents needed for the various labs.

```
config/
├── board
│   └── friendlyarm
│       └── nanopi-neo-plus2
│           ├── boot.cmd
│           ├── genimage.cfg
│           ├── patches
│           │   ├── arm-trusted-firmware
│           │   │   └── 0001_arm-trusted.patch
│           │   └── linux
│           │       └── 0001-linux-sun50i-h5-dtsi.patch
│           ├── post-build.sh
│           ├── readme.txt
│           ├── rootfs_overlay
│           │   ├── etc
│           │   │   ├── network
│           │   │   │   └── interfaces
│           │   │   └── ssh
│           │   │       └── sshd_config
│           │   └── lib
│           │       └── firmware
│           │           └── brcm
│           │               └── brcmfmac43430-sdio.friendlyarm,nanopi-neo-plus2.txt
│           └── uboot-extras.config
└── configs
    └── ses_defconfig
```

```
.devcontainer/
├── devcontainer.json
├── docker-compose.yml
└── toolchain
    ├── Dockerfile
    └── scripts
        └── get-buildroot.sh
```

```
.vscode/
├── launch.json
├── settings.json
└── tasks.json
```
