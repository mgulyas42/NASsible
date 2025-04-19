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

Copy the example playbook for your server(s).
```
cp -rfp playbooks/sample playbooks/YOUR_PLAYBOOK_NAME
```

Configure the following files in your copied playbook:
- `inventory` : add your node(s)
- `group_vars/all.yml`: read the properties and update them as you wish

Jump to your playbook's folder:
```
cd playbooks/YOUR_PLAYBOOK_NAME
```

Create your own secrets
```
ansible-vault create secrets.yml
```

You can set the following secrets, depends on your needs.
- transmission_passwd
- duckdns_token
- mariadb_root_password
- photoprism_db_user_password
- photoprism_admin_password
- nextcloud_db_user_password
- cloudflare_tunnel_token

Run the following script to apply changes on node(s):
```
ansible-playbook nassible.yml -k -K --ask-vault-pass
```

### Todo
- prometheus
- grafana
- cloudflare
- openvpn