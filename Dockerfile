FROM eclipse-temurin:8-jre

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip python3 python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir fastapi uvicorn httpx

COPY clientportal.gw.zip .
RUN unzip -q clientportal.gw.zip && \
    rm clientportal.gw.zip && \
    if [ -d clientportal.gw ] && [ ! -f bin/run.sh ]; then \
        cp -rp clientportal.gw/. . && rm -rf clientportal.gw; \
    fi

COPY bin/run.sh bin/run.sh
COPY root/conf.yaml root/conf.yaml
COPY nexus_server.py nexus_server.py
COPY start.sh start.sh
RUN chmod +x start.sh bin/run.sh

EXPOSE 8080

CMD ["./start.sh"]
