FROM openjdk:11-jre-slim

WORKDIR /app

RUN apt-get update && apt-get install -y unzip curl && \
    curl -L -o gateway.zip https://download2.interactivebrokers.com/portal/clientportal.gw.zip && \
    unzip gateway.zip && \
    rm gateway.zip

EXPOSE 5000

CMD ["sh", "-c", "bin/run.sh root/conf.yaml"]
