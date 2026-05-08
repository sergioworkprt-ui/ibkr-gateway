#!/bin/sh

export JAVA_TOOL_OPTIONS="-Xmx1g -Xms256m"

echo "=== bin/run.sh from zip ==="
cat /app/bin/run.sh
echo "==========================="

# Start gateway using zip's run.sh (correct Main-Class), stderr captured
sh /app/bin/run.sh /app/root/conf.yaml 2>&1 &

# Start FastAPI proxy immediately so Render detects $PORT
exec /opt/venv/bin/python nexus_server.py
