FROM eclipse-temurin:8-jre

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip python3 && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y python3-fastapi python3-uvicorn python3-httpx

COPY clientportal.gw.zip clientportal.gw.zip
RUN unzip -q clientportal.gw.zip && rm clientportal.gw.zip

COPY root/conf.yaml root/conf.yaml
COPY nexus_server.py nexus_server.py
COPY start.sh start.sh
RUN chmod +x start.sh

EXPOSE 8080

CMD ["./start.sh"]
