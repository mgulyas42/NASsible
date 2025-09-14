# NASsible
It is my configurable ansible playbooks. The playbooks are designed to be run on Ubuntu server.

This repository is inspired by and includes code from [ansible-nas](https://github.com/davestephens/ansible-nas).

NASsible is using docker compose.

## Features
List of applications and features that the script can install.

### General
- Docker (`docker`, `geerlingguy.docker`)

### Media
- Calibre
- Jellyfin
- Jackett
- Photoprism
- Radarr
- Sonarr
- Overseerr
- Jellyseerr

### Utilities & Network
- Adguard (⚠ uses ports 80, 443, 53; may conflict with nginx/traefik. Recommended to run on a separate device or VM)
- Duplicati (for backups)
- Transmission
- Traefik (using self-signed cert)
   - [SELF_SIGNED_CERT.md](SELF_SIGNED_CERT.md)
- Tailscale
- Cloudflare
- DuckDNS
- OpenVPN (planned)
- Prometheus

### Apps
- Home Assistant
- Nextcloud
- Grafana
- Homepage
- MariaDB
- Nextcloud


## Setup

### Prerequisites

You must install the requirements first:

```
ansible-galaxy install -r requirements.yml
```

1. **Create your own playbook and navigate to there**
   ```bash
   cp -r playbooks/sample playbooks/YOUR_PLAYBOOK_NAME
   cd playbooks/YOUR_PLAYBOOK_NAME
   ```

2. **Update inventory and configuration files**
   - Update the inventory file: `playbooks/YOUR_PLAYBOOK_NAME/inventory`
   - Update the configuration files: `group_vars/all.yml`

3. **Create your secrets file**
   Use Ansible Vault to securely store sensitive variables:
   ```bash
   ansible-vault create secrets.yml
   ```

   You must define all possible secrets variables in your `secrets.yml` file, but you can  ansible-vault create secrets.ymlleave them empty if a service does not require them. For example:

   ```yaml
   transmission_passwd:
   duckdns_token:
   mariadb_root_password:
   photoprism_db_user_password:
   photoprism_admin_password:
   nextcloud_db_user_password:
   cloudflare_tunnel_token:
   ```

   Fill in the values only for the services you enable. Leave the others as empty strings.

4. **Run the playbook**
   Apply your configuration to the node(s) with:
   ```bash
   ansible-playbook nassible.yml -k -K --ask-vault-pass
   ```
   - `-k`: ask for SSH password (if needed)
   - `-K`: ask for privilege escalation password (sudo, if needed)
   - `--ask-vault-pass`: prompt for your Ansible Vault password

### Todo
- Prometheus support
- More monitoring/alerting tools
- More media and utility applications

---

## Contributing

Contributions are welcome! If you have ideas for new features, want to add support for other services, or improve existing roles, please open an issue or submit a pull request.

If you use a service that is not yet supported, feel free to suggest it or contribute a new role for it!
- grafana
- cloudflare
- openvpn

---

## Adding New Apps / Services

To add support for a new application, use the `sample_service` role as a starting point:

1. Copy the `roles/sample_service` directory to a new role directory (e.g. `roles/myapp`).
2. Rename all occurrences of `sample_service` in files, variables, and filenames to match your new app/service.
3. Update the variables, Docker Compose template, and tasks as needed for your application.
4. Refer to the `roles/sample_service/README.md` for further guidance.
