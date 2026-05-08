#!/bin/sh
cd /app
exec java \
  -cp "/app/root:/app/dist/ibgroup.web.core.iblink.router.clientportal.gw.jar:/app/build/lib/runtime/*" \
  ibgroup.web.core.clientportal.gw.GatewayStart \
  /app/root/conf.yaml
