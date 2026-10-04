# PoC_Dev checkpoint

Snapshot of lab PoC progress. Update this in the same change as `PoC_Dev` work. Decisions belong in `docs/decision-points.md`.

## Identity

| Field | Value |
| --- | --- |
| Branch | `PoC_Dev` |
| Goal | Provision a Proxmox full VM, then configure n8n on it with IaC. |
| Stack | OpenTofu (clone VM) → Ansible (later) |
| Agent instructions | `AGENTS.md`; OpenTofu how-to in `docs/opentofu-proxmox.md` |
| Last updated | 2026-10-04 |
| Last updated by | Cursor agent |

## Current

| Field | Value |
| --- | --- |
| Phase | 1 — OpenTofu: Proxmox full VM |
| Status | In progress (code + docs; not applied) |
| Done this session | `tofu/` clone-from-template; human install guide; branch `PoC_Dev` |
| Next | Install OpenTofu if needed; create API token; copy `terraform.tfvars`; `tofu init` and `tofu plan` against the lab |
| Blockers | DP-006 — real node, template VMID, unused VMID, endpoint, SSH public key |
| Verify | Files exist under `tofu/` and `docs/opentofu-proxmox.md`. No `tofu apply` yet. No VM created by this repo. |

## Phases

| # | Phase | Status | Exit criteria |
| --- | --- | --- | --- |
| 0 | Repo bootstrap | done | README + `AGENTS.md` on `PoC_Dev` |
| 1 | OpenTofu: Proxmox full VM | in progress | `tofu plan` against lab; later a cloned VM |
| 2 | Ansible: OS baseline | not started | Playbook reaches the VM |
| 3 | Ansible: n8n + components | not started | n8n reachable |
| 4 | Lab verify | not started | SSH + n8n URL; secrets not in git |

## History

- 2026-10-03 — Docs created; Cursor rules experiment.
- 2026-10-04 — Started over with `AGENTS.md`.
- 2026-10-04 — Phase 1: OpenTofu layout (clone template) + `docs/opentofu-proxmox.md`.
