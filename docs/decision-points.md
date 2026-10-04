# Decision points

Log of choices. Update this when a decision is made, reversed, or left open. Do not delete rows; mark them `superseded` and add a new row.

`status`: `open` | `accepted` | `superseded`

| ID | Date | Area | Decision | Options considered | Chosen | Status | Rationale / notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DP-001 | 2026-10-03 | Platform | Where does lab n8n run? | Proxmox full VM; LXC; bare metal | Proxmox full VM | accepted | README: lab PoC on a Proxmox full VM via `PoC_Dev`. |
| DP-002 | 2026-10-03 | IaC | How is the VM created? | OpenTofu; Terraform; manual | OpenTofu | accepted | README: OpenTofu provisions the full VM. |
| DP-003 | 2026-10-03 | Config | How is n8n installed on the VM? | Ansible; cloud-init only; manual | Ansible | accepted | README: Ansible sets up n8n and components. Not started. |
| DP-004 | 2026-10-03 | Git | Branch model | `main` prod, `PoC_Dev` lab, `feature/<name>` for prod | as listed | accepted | README intended structure. |
| DP-005 | 2026-10-04 | Agent | How AI is instructed | `.cursor/rules`; root `AGENTS.md` | `AGENTS.md` | accepted | Single-user repo; long how-tos in `docs/`. |
| DP-006 | 2026-10-03 | Proxmox facts | Node, VMID, template ID, network | TBD per lab | — | open | Fill `tofu/terraform.tfvars` from the real cluster. |
| DP-007 | 2026-10-03 | n8n runtime | Install method on the VM | Docker/Compose via Ansible; native packages; n8n binary | — | open | After the VM exists. |
| DP-008 | 2026-10-03 | Data | n8n database | SQLite (lab); Postgres | — | open | After the VM exists. |
| DP-009 | 2026-10-04 | State | OpenTofu state backend | Local on `PoC_Dev`; remote backend | Local in `tofu/` | accepted | Learning/PoC. Never commit `*.tfstate`. |
| DP-010 | 2026-10-04 | Secrets | How secrets enter apply | gitignored `terraform.tfvars`; `TF_VAR_*` / env | both allowed | accepted | Example file only in git. |
| DP-011 | 2026-10-04 | VM source | How the guest disk is created | Clone template; ISO from scratch; linked clone | Full clone of a cloud-init template | accepted | Fastest lab path. ISO later if needed. Provider: `bpg/proxmox` 0.115.0. |
| DP-012 | 2026-10-04 | Guest agent | Wait on qemu-guest-agent | on; off | off by default | accepted | Avoid hung `apply` if the template has no agent. |
