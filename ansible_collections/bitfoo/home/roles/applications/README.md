# Ansible Role: Install Applications

This Ansible role automates the installation of applications on both Linux and
macOS (Darwin) systems. It supports installing packages using Flatpak, Homebrew,
and native package managers, allowing flexibility in managing applications
across different environments.

## 📋 Overview

The role performs the following tasks:

### 🐧 On Linux Systems

1. **Install Flatpak applications** from the Flathub repository (if enabled).
2. **Install distribution packages** using the system's package manager
   (e.g., `apt`, `dnf`, `yum`).

### 🍏 On macOS Systems

1. **Install Homebrew packages** using `brew`.
2. **Install Homebrew cask applications** using `brew cask`.

## 📦 Requirements

- Ansible version **2.1** or higher.
- The role requires the following external roles:
  - `bitfoo.home.flatpak` (for Flatpak support on Linux).
  - `geerlingguy.mac.homebrew` (for Homebrew support on macOS).

## 🔧 Role Variables

The role uses the following variables, which can be customized as needed:

| Variable | Default | Description |
|----------|---------|-------------|
| `applications_flatpak_enabled` | `true` | Whether to enable Flatpak installations on Linux. |
| `applications_flatpak_packages` | `[]` | List of Flatpak packages to install (only applicable if Flatpak is enabled). |
| `applications_distribution_packages` | `[]` | List of distribution packages to install on Linux. |
| `applications_homebrew_packages` | `[]` | List of Homebrew packages to install on macOS. |
| `applications_homebrew_cask_packages` | `[]` | List of Homebrew cask packages to install on macOS. |

## Example Playbook

- name: Install Applications on Clients
  hosts: all
  gather_facts: yes
  vars:
    applications_flatpak_enabled: true
    applications_flatpak_packages:
      - org.mozilla.firefox
      - com.discordapp.Discord
    applications_distribution_packages:
      - git
      - curl
    applications_homebrew_packages:
      - tree
      - jq
    applications_homebrew_cask_packages:
      - slack
      - iterm2
  roles:
    - { role: install_applications }
