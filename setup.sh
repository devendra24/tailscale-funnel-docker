#!/bin/sh

# Start Tailscale daemon
tailscaled &

# Wait for daemon
sleep 5

# Connect to Tailnet
tailscale up --authkey=${TS_AUTHKEY} --hostname=${HOSTNAME}

# Enable Funnel for app port
tailscale funnel ${APP_PORT}

# Wait a few seconds for Funnel to be ready
sleep 5

# Generate TLS cert for MagicDNS domain
tailscale cert ${DOMAIN} > /dev/null

# Print the public Funnel URL
echo "Your app is publicly accessible at:"
tailscale funnel url ${APP_PORT}

# Keep container alive
tail -f /dev/null
