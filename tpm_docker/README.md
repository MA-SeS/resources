# HOWTO

## use the .devcontainer

Launch the `.devcontainer` and then, once the container is ready, issue: 

```bash
swtpm socket --tpmstate dir=/tpm2/tpm --tpm2 --server type=tcp,port=2321,bindaddr=0.0.0.0 --ctrl type=tcp,port=2322,bindaddr=0.0.0.0 --flags not-need-init,startup-clear
```

## OR build and launch the image present in the project

To build and run it :

- `docker build --tag tpm_img .`
- `docker run -it --name tpm -p 2321:2321 -p 2322:2322 tpm_img`

## IMPORTANT: install the tools in the .devcontainer of the `buildroot` environment

From the machine you would like to access the _TPM_ we will interact with the
"chip". Here it is assumed that it will be the environment used for building
`buildroot`. Obviously, this can be done in any environment for as long as the
below commands work:
- Install tpm2 commands 
  ```bash
  apt install tpm2-tools
  ```
- Make your _SW TPM_ accessible from this managing machine
  ```bash
  export TPM2TOOLS_TCTI="swtpm:host=HOST_IP_ADDRESS"
  ```