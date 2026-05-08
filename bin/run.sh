#!/bin/sh
cd /app

# Read Main-Class directly from JAR manifest - no guessing
MAIN_CLASS=$(unzip -p /app/dist/ibgroup.web.core.iblink.router.clientportal.gw.jar META-INF/MANIFEST.MF 2>/dev/null \
  | grep "^Main-Class:" \
  | sed 's/Main-Class: *//' \
  | tr -d '\r\n')

if [ -z "$MAIN_CLASS" ]; then
  echo "WARNING: could not read Main-Class from manifest, using fallback"
  MAIN_CLASS="ibgroup.web.core.iblink.router.clientportal.gw.StartServer"
fi

echo "=== Main-Class: ${MAIN_CLASS} ==="
echo "=== Args: $@ ==="

exec java \
  -cp "/app/root:/app/dist/ibgroup.web.core.iblink.router.clientportal.gw.jar:/app/build/lib/runtime/*" \
  "${MAIN_CLASS}" \
  "$@"
