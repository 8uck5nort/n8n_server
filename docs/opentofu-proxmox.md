# OpenTofu + Proxmox (PoC)

Human reference for the first lab step: install OpenTofu, talk to an **existing** Proxmox server, and clone a full VM. IaC files live in `tofu/`.

PoC choice: **clone a template** (usually a Ubuntu cloud-init image converted to a template). Faster and more repeatable than an ISO install. ISO-from-scratch is a later option, not this cut.

Do not `tofu apply` until lab values in `tofu/terraform.tfvars` are real. Do not commit that file or any `*.tfstate`.

## 1. Install OpenTofu (Debian / Ubuntu / WSL)

Official docs: https://opentofu.org/docs/intro/install/deb/

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://get.opentofu.org/opentofu.gpg | sudo tee /etc/apt/keyrings/opentofu.gpg >/dev/null
curl -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey | sudo gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg >/dev/null
sudo chmod a+r /etc/apt/keyrings/opentofu.gpg /etc/apt/keyrings/opentofu-repo.gpg

echo \
  "deb [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main
deb-src [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main" | \
  sudo tee /etc/apt/sources.list.d/opentofu.list >/dev/null

sudo apt-get update
sudo apt-get install -y tofu
tofu version
```

Standalone installer (any Linux) if you prefer not to add an apt repo: https://opentofu.org/docs/intro/install/standalone/

## 2. API token on the existing Proxmox host

Lab-simple: a dedicated user whose token has the same rights as the user (`Privilege Separation` off). Tighten later.

In the Proxmox UI:

1. Datacenter → Permissions → Users → Add (e.g. `tofu` / realm `pve`).
2. Datacenter → Permissions → Add → User permission on path `/` with a role that can clone/create VMs (for PoC, `Administrator` is enough; replace later).
3. Datacenter → Permissions → API Tokens → Add for `tofu@pve`, Privilege Separation **unchecked**.
4. Copy the token **once**. The string OpenTofu needs is:

`tofu@pve!poc=<secret>`

From the Proxmox shell instead:

```bash
pveum user add tofu@pve --comment "OpenTofu PoC"
pveum aclmod / -user tofu@pve -role Administrator
pveum user token add tofu@pve poc --privsep 0 --comment "n8n PoC"
```

Use `https://<proxmox-host>:8006/` as the endpoint. Do **not** append `/api2/json`.

If the lab cert is self-signed, keep `proxmox_insecure = true`.

## 3. One-time: cloud-init template (if you do not have one)

Skip this if you already have a template VMID.

On a Proxmox node (example: Ubuntu 24.04 cloud image → VMID 9000). Adjust storage names (`local`, `local-lvm`) to match the lab.

```bash
cd /var/tmp
wget -O ubuntu-24.04-cloud.img \
  https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img

qm create 9000 --name ubuntu-24.04-cloud --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 ubuntu-24.04-cloud.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --boot order=scsi0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
qm template 9000
```

Note the VMID (`9000` here). That is `template_vm_id` in tfvars. Guest user for Ubuntu cloud images is `ubuntu`.

Optional: install `qemu-guest-agent` inside a temporary clone, convert that clone to the template, then set `qemu_agent = true` in tfvars so OpenTofu can read the guest IP.

## 4. Fill in lab values

```bash
cd tofu
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars — endpoint, token, node, template_vm_id, unused vm_id, ssh public key
```

Or keep the token out of the file:

```bash
export TF_VAR_proxmox_api_token='tofu@pve!poc=...'
```

`ssh_public_key` is the **public** key that will be able to log in as `vm_user`.

## 5. Init, plan, apply

From `tofu/`:

```bash
tofu init
tofu plan
```

`plan` should show **one VM to create** (clone). If authentication fails, check endpoint, token format, and that port 8006 is reachable from this machine.

When you are ready to create the VM:

```bash
tofu apply
```

Do not run `tofu destroy` unless you intend to delete that VM.

If `qemu_agent` is false, OpenTofu will not print a reliable guest IP. Use the Proxmox UI, DHCP lease, or console.

SSH (after the guest has an address):

```bash
ssh ubuntu@<guest-ip>
```

## 6. What this does not do yet

- Ansible / n8n install (next PoC phase)
- Remote OpenTofu state
- Production-least-privilege Proxmox role
- Installing the OS from an ISO

## Related files

| Path | Role |
| --- | --- |
| `tofu/*.tf` | OpenTofu config |
| `tofu/terraform.tfvars.example` | Shape of lab inputs |
| `AGENTS.md` | Short AI instructions (points here for install steps) |
