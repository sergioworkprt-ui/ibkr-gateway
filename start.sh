#!/bin/sh

# Start IBKR Client Portal Gateway in background
sh bin/run.sh root/conf.yaml &

# Wait for gateway to initialize
sleep 8

# Start FastAPI proxy using venv python in foreground (Render monitors this process)
exec /opt/venv/bin/python nexus_server.py
