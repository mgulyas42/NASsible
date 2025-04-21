# NASsible
It is my configurable ansible playbooks. The playbooks are designed to be run on Ubuntu server.

This repository is inspired by and includes code from [ansible-nas](https://github.com/davestephens/ansible-nas).

NASsible is using docker compose.

## Features
List of applications and features what the script can install.
### General
- Install docker

### Media
- Calibre
- Jellyfin
- Jackett
- Photoprism
- Radarr

### Utilities & Network
- Adguard (⚠ it's using port 80, 443, 53 ports what can conflict with nginx, traefix. Highly recommended to run this on different device or VM)
- Duplicati (for backups)
- Transmission
- Traefik (using self signed cert yet)

### Apps
- Home Assistant
- Nextcloud


## Setup
FYI not tested for a while. You must install the requirements

```
ansible-galaxy install -r requirements.yml
```

2. **Navigate to your playbook folder**
   ```bash
   cd playbooks/YOUR_PLAYBOOK_NAME
   ```

3. **Create your secrets file**
   Use Ansible Vault to securely store sensitive variables:
   ```bash
   ansible-vault create secrets.yml
   ```

   You must define all possible secrets variables in your `secrets.yml` file, but you can leave them empty if a service does not require them. For example:

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