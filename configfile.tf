resource "proxmox_virtual_environment_file" "cloud-init-configfile" {
  node_name    = var.node_name
  content_type = "snippets"
  datastore_id = "local"

  source_raw {
    data = templatefile("${path.module}/cloud-init/common.yaml.tftpl", {
      hostname = var.hostname
      user = var.user
      user_password = var.user_password
      user_pub_key  = var.user_pub_key
      vm_data_mount_address = var.vm_data_mount.address
      vm_data_mount_share = var.vm_data_mount.share
      vm_data_mount_username = var.vm_data_mount.username
      vm_data_mount_password = var.vm_data_mount.password
    })
    file_name = format("%s-%s", var.hostname, "cloud-init-lab-git.yaml")
  }
}
