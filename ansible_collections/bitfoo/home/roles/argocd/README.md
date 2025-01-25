# Ansible Role: ArgoCD Installer

This Ansible role automates the installation and management of **ArgoCD Cli** on
both **Linux** and **macOS (Darwin)** systems. It fetches the latest ArgoCD Cli
release from GitHub, installs or upgrades the CLI tool, and sets up shell
completions.

## 📋 Overview

The role performs the following tasks:

1. **Check the currently installed version** of ArgoCD Cli on the system.
2. **Fetch the latest ArgoCD Cli release version** from the official GitHub repository.
3. If a newer version is available or installation is forced:
   - Download the appropriate binary for the detected OS and architecture.
   - Install or upgrade the ArgoCD CLI.
   - Generate and install shell completions for `bash` and `zsh`.

## 📦 Requirements

- Ansible version **2.1** or higher.
- The role requires internet access to fetch releases from GitHub.

## 🔧 Role Variables

The following variables can be customized to control the behavior of the role:

| Variable               | Default                 | Description                                                                                        |
| ---------------------- | ----------------------- | -------------------------------------------------------------------------------------------------- |
| `argocd_force_install` | `false`                 | If set to `true`, forces reinstallation of ArgoCD even if the latest version is already installed. |
| `github_api_headers`   | `undefined`             | Optional GitHub API headers (e.g., for authentication to avoid rate limits).                       |

## ⚙️ Supported OS Architectures

This role currently supports:

- **Linux**:
  - `x86_64` → `linux-amd64`
  - `aarch64` → `linux-arm64`
- **macOS (Darwin)**:
  - `arm64` → `darwin-arm64`

## 🚀 Example Playbook

Here’s how to use this role in your playbook:

```yaml
- name: Install or Upgrade ArgoCD
  hosts: all
  gather_facts: yes
  vars:
    argocd_force_install: false
    github_api_headers:
      Authorization: "Bearer {{ github_token }}"
  roles:
    - role: install_argocd
```

## 🛠️ Role Dependencies

```yaml
bitfoo.home.xdg_dirs
```

## 📄 License

This project is licensed under the **MIT License**.

## 🐛 Issues

Please report issues via the [GitLab issue tracker](https://gitlab.com/bitfooxyz/dots/-/issues).

## 👤 Author

Developed by **Daniel von Essen**.
