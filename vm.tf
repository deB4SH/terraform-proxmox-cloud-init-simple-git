resource "proxmox_virtual_environment_vm" "vm-git" {
  node_name = var.node_name

  name        = var.hostname
  description = var.vm_description
  tags        = ["vm", "git"]
  on_boot     = true
  vm_id       = var.vm_id

  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "ovmf"

  cpu {
    cores = var.vm_cpu_cores
    type  = "host"
  }

  memory {
    dedicated = var.vm_memory
  }

  network_device {
    bridge      = var.vm_network.bridgename
    mac_address = var.vm_network.mac_address
  }

  efi_disk {
    datastore_id = var.vm_datastore_id
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = var.vm_datastore_id
    file_id      = proxmox_virtual_environment_download_file.generic_image.id
    interface    = "scsi0"
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    size         = 32
  }

  boot_order = ["scsi0"]

  agent {
    enabled = true
  }

  operating_system {
    # Linux Kernel 2.6 - 6.X.
    type = "l26" 
  }

  initialization {
    dns {
      domain  = var.vm_dns.domain
      servers = var.vm_dns.servers
    }
    ip_config {
      ipv4 {
        address = var.vm_ip_config.address
        gateway = var.vm_ip_config.gateway
      }
    }

    datastore_id      = var.vm_datastore_id
    user_data_file_id = proxmox_virtual_environment_file.cloud-init-configfile.id
  }
}