Public resources for the course "MA Secure Embedded Systems"

This is the contents needed for the various labs:

```
labs/
├── .devcontainer
│   ├── devcontainer.json
│   ├── devenv
│   │   └── Dockerfile
│   └── docker-compose.yml
└── resources
    └── utilities
        └── sd_copy.sh
```

**Important note**: in order for the copy of the compiled image to work, one needs to have a `sd_folder` under `/workspace` for it to work. If one chooses a different structure, the person needs to adapt the `sd_copy.sh` script.