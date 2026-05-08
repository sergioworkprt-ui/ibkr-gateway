#!/bin/sh
set -e

export JAVA_TOOL_OPTIONS="-Xmx384m -Xms64m"

# Start IBKR Client Portal Gateway with absolute path to conf.yaml
sh bin/run.sh /app/root/conf.yaml &

# Start FastAPI proxy immediately so Render detects $PORT
exec /opt/venv/bin/python nexus_server.py
