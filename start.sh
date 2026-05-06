#!/bin/sh
set -e

if [ ! -f "bin/run.sh" ]; then
  echo "Downloading IBKR Client Portal Gateway..."
  curl -L --max-time 120 --retry 3 --retry-delay 5 \
    -o gateway.zip \
    https://download2.interactivebrokers.com/portal/clientportal.gw.zip
  unzip -q gateway.zip
  rm gateway.zip
  echo "Gateway extracted."
fi

exec sh bin/run.sh root/conf.yaml
