#!/bin/sh

# Start IBKR Client Portal Gateway in background
sh bin/run.sh root/conf.yaml &

# Wait for gateway to initialize
sleep 8

# Start FastAPI proxy in foreground (Render monitors this process)
exec python3 nexus_server.py
