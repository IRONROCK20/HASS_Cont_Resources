#!/usr/bin/env bash
set -e

# Start Nginx for Ingress UI
nginx -g 'daemon off;' &

# Launch the limiter logic in background
/run-limiter.sh &

# Start the Express-based API server
node /app/index.js
