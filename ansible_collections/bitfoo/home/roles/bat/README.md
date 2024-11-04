# TokyoNight Theme Setup

This role automates the installation of the
[TokyoNight](https://github.com/folke/tokyonight.nvim) colorscheme for Neovim.

It performs the following steps:

1. Creates necessary directories for theme configuration.
2. Fetches the latest release version of TokyoNight from GitHub.
3. Clones the TokyoNight repository at the latest release version.

## Variables

| Variables | Default | Description |
| :-------- | :------:| :---------- |
| `github_api_headers` | "" | A dictionary containing any necessary headers for GitHub API requests, such as authentication tokens if required for higher rate limits. |

## Usage

```yaml
- name: Example playbook
  hosts: localhost
  gather_facts: no
  vars:
    github_api_headers:
      Authorization: "token YOUR_GITHUB_TOKEN"
  tasks:
    - name: Setup TokyoNight Theme
      ansible.builtin.import_role:
        name: tokyonight
```
