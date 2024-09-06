# NASsible
It is my configurable ansible playbooks. The playbooks are designed to be run on Ubuntu server.

This repository is inspired by and includes code from [ansible-nas](https://github.com/davestephens/ansible-nas).

NASsible is using docker compose.

## Features
- Install docker
- Calibre

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

Run the following script to apply changes on node(s):
```
ansible-playbook nassible.yml -k -K 
```