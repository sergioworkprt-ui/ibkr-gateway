#!/bin/sh

export JAVA_TOOL_OPTIONS="-Xmx1g -Xms256m"

# Start IBKR gateway (stderr to stdout so errors appear in Render logs)
sh /app/bin/run.sh 2>&1 &
GW_PID=$!

# Background monitor: log every 10s whether port 5000 is open
(/opt/venv/bin/python3 -c "
import socket, time
for i in range(30):
    time.sleep(10)
    try:
        s = socket.create_connection(('localhost', 5000), timeout=2)
        s.close()
        print('GATEWAY UP on port 5000 after {}s'.format((i+1)*10), flush=True)
        break
    except OSError:
        print('port 5000 not open yet ({}s)'.format((i+1)*10), flush=True)
else:
    print('GATEWAY NEVER opened port 5000 after 300s', flush=True)
" 2>&1) &

# Start FastAPI proxy immediately so Render detects PORT
exec /opt/venv/bin/python nexus_server.py
