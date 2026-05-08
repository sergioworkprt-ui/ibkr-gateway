#!/bin/sh
set -e

export JAVA_TOOL_OPTIONS="-Xmx256m -Xms64m"

# Start IBKR Client Portal Gateway in background
sh bin/run.sh root/conf.yaml &

# Wait until gateway is actually listening on port 5000 (up to 90s)
/opt/venv/bin/python -c "
import socket, time, sys
for i in range(90):
    try:
        s = socket.create_connection(('localhost', 5000), timeout=1)
        s.close()
        print('Gateway ready on port 5000')
        sys.exit(0)
    except OSError:
        time.sleep(1)
print('ERROR: Gateway did not start within 90s')
sys.exit(1)
"

exec /opt/venv/bin/python nexus_server.py
