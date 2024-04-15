#image from here: https://cloud.debian.org/images/cloud/bookworm/daily/20240412-1715/
resource "proxmox_virtual_environment_download_file" "generic_image" {
  node_name    = var.node_name
  content_type = "iso"
  datastore_id = "local"

  file_name          = format("%s-%s-%s",var.hostname,var.vm_id,"debian-12-generic-arm64-daily-20240412-1715.img")
  url                = "https://cloud.debian.org/images/cloud/bookworm/daily/20240412-1715/debian-12-generic-amd64-daily-20240412-1715.qcow2"
  checksum           = "f24d72f5cd67047f51c6d59fb857f7bdee6371bb20bbfc026e4028f74d7f7e46506e3155067ad7210da183f94516135d3d1617080afeca991f89f69ff57d060b"
  checksum_algorithm = "sha512"
}