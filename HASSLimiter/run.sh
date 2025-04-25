#!/usr/bin/with-contenv bashio
set -e

# Launch Nginx for Ingress
nginx -g 'daemon off;' &

# Start background limiter
/run-limiter.sh &

# Start Express API
node /app/index.js
