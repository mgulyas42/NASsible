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
### Utilities & Network
- Adguard (⚠ it's using port 80, 443, 53 ports what can conflict with nginx, traefix. Highly recommended to run this on different device or VM) 


## Setup
You must install the requirements

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

Define transmission_passwd in your vault.

Run the following script to apply changes on node(s):
```
ansible-playbook nassible.yml -k -K --ask-vault-pass
```

### Todo
- homepage
- prometheus
- grafana
- home assistant
- duplicati
- traefik
- cloudflare
- jellyfin