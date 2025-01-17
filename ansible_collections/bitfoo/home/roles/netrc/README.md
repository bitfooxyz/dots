# netrc Role

This Ansible role manages the `.netrc` file for configuring machine-specific login credentials.

## Requirements

- Ansible 2.9 or higher
- Supported on all major Unix platforms

## Important Notice

**Do not store any credentials in plain text.** Use `ansible-vault` to encrypt sensitive information such as passwords and API keys. This ensures that your credentials are securely stored and protected.

For more information, refer to the [Ansible Vault documentation](https://docs.ansible.com/ansible/latest/user_guide/vault.html).

## Role Variables

| Variable         | Description                             | Default Value |
|------------------|-----------------------------------------|---------------|
| `netrc_path`     | Path to the `.netrc` file               | `~/.netrc`    |
| `netrc_machines` | List of machines with their credentials | `[]`          |

### Example `netrc_machines` Structure

```yaml
netrc_machines:
  - machine: example.com
    login: myusername
    password: mypassword
  - machine: another.com
    login: anotheruser
    password: anotherpass
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: bitfoo.home.netrc
      netrc_path: "/home/user/.netrc"
      netrc_machines:
        - machine: example.com
          login: myusername
          password: mypassword
```

## License

MIT

## Author Information

This role was created by Bitfoo.
