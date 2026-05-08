#!/bin/sh

export JAVA_TOOL_OPTIONS="-Xmx1g -Xms256m"

echo "=== /app/bin/run.sh in use ==="
cat /app/bin/run.sh
echo "=============================="

# Start gateway: stderr redirected to stdout so all Java errors appear in Render logs
sh /app/bin/run.sh /app/root/conf.yaml 2>&1 &

# Start FastAPI proxy immediately so Render detects $PORT
exec /opt/venv/bin/python nexus_server.py
