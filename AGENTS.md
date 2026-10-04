# Agent instructions

This is a **single-user repo with AI support**. Follow `README.md`. Start simple and add complexity only after the current step works. Do not add `.cursor/rules` unless Darin asks.

Human how-tos live under `docs/`. Point at those files instead of repeating long install steps in chat.

## Purpose

1. Common repository to **lifecycle an n8n server**.
2. Build n8n on a **Proxmox full VM** in the lab, on branch `PoC_Dev`.

## Requirements

Use Infrastructure as Code where it fits. Prefer files in git over one-off GUI or SSH steps.

## PoC_Dev stack

1. **OpenTofu** (`tofu/`) — clone a full VM from an existing Proxmox template on an existing Proxmox server.
2. **Ansible** — set up n8n on that VM (not started yet).

Install OpenTofu, API tokens, and template creation: `docs/opentofu-proxmox.md`.

## Branches

| Role | Branch |
| --- | --- |
| Production | `main` |
| Lab PoC | `PoC_Dev` |
| Production work | `feature/<name>` |

Keep PoC and prod changes separate. Do this lab work on `PoC_Dev`.

## Working agreement

- Change the repo directly. Small steps. Verify with commands (`tofu plan` before `apply`).
- No secrets in git (tokens, keys, `terraform.tfvars`, `*.tfstate`).
- Do not destroy lab VMs or volumes unless Darin asks.
- When a choice is made or PoC_Dev moves forward, update `docs/decision-points.md` and `docs/poc-dev-checkpoint.md` in the same change.
