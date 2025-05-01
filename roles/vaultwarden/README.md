# Sample Ansible Role: sample_service

This is a template role based on the Grafana role. Copy this directory and update names/properties to create new service roles easily.

## Structure
- `defaults/main.yml`: Default variables for the service
- `tasks/sample_service.yml`: Main playbook logic for the service
- `templates/docker-compose.yaml.j2`: Jinja2 template for the service's Docker Compose file (if needed)

## Usage
1. Copy this role and rename files/variables from `sample_service` to your target service name.
2. Update the variables in `defaults/main.yml`.
3. Update the Docker Compose template and tasks as needed.

---
