FROM eclipse-temurin:8-jre

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends unzip curl && \
    rm -rf /var/lib/apt/lists/*

COPY root/conf.yaml root/conf.yaml
COPY start.sh start.sh
RUN chmod +x start.sh

EXPOSE 5000

CMD ["./start.sh"]
