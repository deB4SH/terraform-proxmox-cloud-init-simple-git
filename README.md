# Terraform Proxmox Simple Git

This small terraform module sets up a minimalistic vm within proxmox and provides an unsecured git service via the configured ip address. Additionally a git viewer is in place to view the currently provided git services. 

## Goal
Why? Just use github? Why do this ultra complex setup?

The goal of this module and setup is to provide a git service within a semi airgapped environment. 
Sometimes you don't want to externalize some configurations. You may want to keep some workload configuration within your network to reduce the attack vectors. 

## Setup 
To use this module follow these steps.
First lets create a provider within your main.tf that holds the connection information towards your proxmox environment.

```yaml
provider "proxmox" {
  alias    = "lab_env"
  endpoint = var.lab_env.endpoint
  insecure = var.lab_env.insecure

  api_token = var.lab_env_auth.api_token
  ssh {
    agent    = true
    username = var.lab_env_auth.username
  }

  tmp_dir = "/var/tmp"
}
```

After this you need to pass the provider to this module via `providers`. 
It is also required to configure some additional fields that do not provide a default configuration.
A general overview of all variables is available within the [variables.tf](https://github.com/deB4SH/terraform-proxmox-cloud-init-simple-git/blob/0.1/variables.tf)

```yaml
module "vm-git" {
  providers = {
    proxmox = proxmox.lab_env
  }
  source = "github.com/deB4SH/terraform-proxmox-cloud-init-simple-git?ref=0.1"

  user = var.vm_user
  user_password = var.vm_password
  user_pub_key = var.host_pub-key

  vm_dns = {
    domain = "."
    servers = ["8.8.8.8","8.8.4.4"]
  }

  vm_network = {
    bridgename = "vmbr0"
    mac_address = "BC:24:11:2E:C0:03"
  }
  
  vm_ip_config = {
    address = "YOUR_DESIRED_IP_HERE/24"
    gateway = "YOUR_GATEWAY_HERE"
  }

  vm_data_mount = {
    address = "YOUR_SAMBA_ENDPOINT"
    share = "YOUR_SAMBA_SHARE_NAME"
    username = "YOUR_SAMBA_SHARE_USER"
    password = "YOUR_SAMBA_SHARE_USERPASSWORD"
  }
}
```

