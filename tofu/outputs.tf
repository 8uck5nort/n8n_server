output "vm_id" {
  value = proxmox_virtual_environment_vm.n8n.vm_id
}

output "vm_name" {
  value = proxmox_virtual_environment_vm.n8n.name
}

output "vm_node" {
  value = proxmox_virtual_environment_vm.n8n.node_name
}

output "ipv4_addresses" {
  description = "Populated when qemu-guest-agent is enabled and running in the guest."
  value       = try(proxmox_virtual_environment_vm.n8n.ipv4_addresses, [])
}
