variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API URL, e.g. https://pve.lab.local:8006/. Do not append /api2/json."
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "API token as user@realm!tokenid=secret. Prefer env TF_VAR_proxmox_api_token."
}

variable "proxmox_insecure" {
  type        = bool
  default     = true
  description = "Skip TLS verify. Typical for lab self-signed certs."
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name that will host the VM."
}

variable "template_vm_id" {
  type        = number
  description = "Existing template (or VM) ID to clone. Create a cloud-init template once; see docs/opentofu-proxmox.md."
}

variable "vm_id" {
  type        = number
  description = "New VMID. Must be unused on the cluster."
}

variable "vm_name" {
  type        = string
  default     = "n8n-poc"
  description = "Guest name in Proxmox."
}

variable "vm_cpu_cores" {
  type        = number
  default     = 2
}

variable "vm_memory_mb" {
  type        = number
  default     = 4096
}

variable "disk_datastore" {
  type        = string
  default     = "local-lvm"
  description = "Datastore for the cloned disk."
}

variable "network_bridge" {
  type        = string
  default     = "vmbr0"
}

variable "vlan_id" {
  type        = number
  default     = null
  description = "Optional VLAN tag. Leave unset for untagged."
}

variable "vm_ipv4" {
  type        = string
  default     = "dhcp"
  description = "Cloud-init IPv4: dhcp or CIDR like 192.168.1.50/24."
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
  description = "Cloud-init user. Match the template OS (ubuntu, debian, etc.)."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected via cloud-init."
}

variable "qemu_agent" {
  type        = bool
  default     = false
  description = "Enable only if the template has qemu-guest-agent. Otherwise apply can hang."
}
