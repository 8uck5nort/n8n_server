# n8n_server
N8N Server Repo

# Purpose
1. Build a common repository to lifecycle an N8N server.
2. Build an n8n server on a Proxmox full VM in a lab environment using the poc_dev branch.

# Requirements
1. Use various coding technologies/techniques where appropriate for a full Infrastructure as Code approach.

# Desired Technology Paths.
1. I desire the initial PoC_Dev Branch will start with the following technologies.
   A. OpenTofu to provision a full vm on a Proxox server.
   B. Ansible for setup of the N8N server and its components.

# Initial Overview of the Intended Repo Structure
1. Prod - Branch Main
2. PoC - Branch PoC_Dev
3. Prod - Branch Feature {{ name }}

# PoC_Dev (current)
- AI instructions: `AGENTS.md`
- OpenTofu (clone VM from a Proxmox template): `tofu/`
- How to install OpenTofu and talk to Proxmox: `docs/opentofu-proxmox.md`
