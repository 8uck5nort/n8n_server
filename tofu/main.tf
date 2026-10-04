# PoC path: clone an existing Proxmox template (cloud-init image recommended).
# From-scratch ISO installs are slower and not in this first cut — see docs/opentofu-proxmox.md.

resource "proxmox_virtual_environment_vm" "n8n" {
  name        = var.vm_name
  node_name   = var.proxmox_node
  vm_id       = var.vm_id
  description = "Lab PoC n8n VM — OpenTofu"
  tags        = ["poc", "n8n"]

  clone {
    vm_id = var.template_vm_id
    full  = true
    datastore_id = var.disk_datastore
  }

  cpu {
    cores = var.vm_cpu_cores
  }

  memory {
    dedicated = var.vm_memory_mb
  }

  agent {
    enabled = var.qemu_agent
  }

  initialization {
    user_account {
      username = var.vm_user
      keys     = [var.ssh_public_key]
    }

    ip_config {
      ipv4 {
        address = var.vm_ipv4
      }
    }
  }

  network_device {
    bridge  = var.network_bridge
    vlan_id = var.vlan_id
  }

  started = true
}
