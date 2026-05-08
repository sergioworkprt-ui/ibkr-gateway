#!/bin/sh

# Force public DNS at runtime (Kubernetes may overwrite /etc/resolv.conf at pod start)
echo "nameserver 8.8.8.8" > /etc/resolv.conf

export JAVA_TOOL_OPTIONS="-Xmx1g -Xms256m"

# </dev/null prevents gateway from reading closed stdin (Stream closed error)
sh /app/bin/run.sh </dev/null 2>&1 &

# Background monitor: log when port 5000 opens
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

exec /opt/venv/bin/python nexus_server.py
