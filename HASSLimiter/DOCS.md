# Container Limiter

This add-on lets you select any Supervisor-managed container, set CPU and memory limits per-container,  
and automatically enforces them on boot and whenever containers start/update.

## Developer Notes

- Uses `docker update` under the hood (requires `privileged: true`).  
- GUI powered by a small Node/Express API and static HTML/JS via Ingress.  
- Background script listens to `docker events` to re-apply limits dynamically.

