variable "node_name" {
  type        = string
  description = "Node to deploy services to"
  default     = "pve"
}

variable "hostname" {
  type        = string
  description = "Hostname to set within the vm"
  default     = "git"
}

variable "vm_description" {
  type        = string
  description = "Description for the vm"
  default     = "Git service"
}

variable "vm_id" {
  type        = number
  description = "VM id to register"
  default     = 9000
}

variable "vm_cpu_cores" {
  type        = number
  description = "Amount of cores to use"
  default     = 1
}

variable "vm_memory" {
  type        = number
  description = "Amount of dedicated memory to allocatee"
  default     = 1024
}

variable "vm_dns" {
  description = "DNS config for VM"
  type = object({
    domain  = string
    servers = list(string)
  })
}

variable "vm_network" {
  description = "Network config for VM"
  type = object({
    bridgename  = string
    mac_address = string
  })
}

variable "vm_ip_config" {
  description = "IP config for VM"
  type = object({
    address = string
    gateway = string
  })
}

variable "vm_datastore_id" {
  type        = string
  description = "Datastore to use for drives"
  default     = "local-lvm"
}

variable "vm_data_mount" {
  description = "Mount for externalizing data"
  type = object({
    address = string
    share = string
    username = string
    password = string
  })
}

variable "user" {
  type        = string
  description = "Default user to create and run from"
  default     = "carrot"
}

variable "user_password" {
  type        = string
  sensitive   = true
  description = "Default user password to set"
  #echo -n password | sha256sum | awk '{printf "%s",$1 }' | sha256sum
  default = "113459eb7bb31bddee85ade5230d6ad5d8b2fb52879e00a84ff6ae1067a210d3"
}

variable "user_pub_key" {
  type        = string
  sensitive   = true
  description = "Public key to use for authentication."
  #ssh-keygen -t ed25519 -C "<EMAIL>"
  default = ""
}
