#!/bin/sh

export JAVA_TOOL_OPTIONS="-Xmx1g -Xms256m"

# Start IBKR gateway (stderr captured so errors appear in Render logs)
sh /app/bin/run.sh 2>&1 &

# Start FastAPI proxy immediately so Render detects $PORT
exec /opt/venv/bin/python nexus_server.py
