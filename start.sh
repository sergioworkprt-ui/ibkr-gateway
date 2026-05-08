#!/bin/sh
set -e

# Increase JVM heap - Vert.x needs ~300MB+ to initialize
export JAVA_TOOL_OPTIONS="-Xmx384m -Xms64m"

# Start IBKR Client Portal Gateway in background
sh bin/run.sh root/conf.yaml &

# Start FastAPI proxy immediately so Render detects $PORT
# Proxy returns 503 while gateway is initializing, then proxies normally
exec /opt/venv/bin/python nexus_server.py
