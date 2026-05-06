FROM eclipse-temurin:8-jre

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends unzip curl && \
    curl -L -o gateway.zip https://download2.interactivebrokers.com/portal/clientportal.gw.zip && \
    unzip gateway.zip && \
    rm gateway.zip && \
    rm -rf /var/lib/apt/lists/*

COPY root/conf.yaml root/conf.yaml

EXPOSE 5000

CMD ["sh", "-c", "bin/run.sh root/conf.yaml"]
