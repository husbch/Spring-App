FROM ubuntu:18.04

RUN apt update && apt upgrade -y && apt install -y dnsutils curl openjdk-8-jre

MAINTAINER Husni

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]

RUN dig +short myip.opendns.com @resolver1.opendns.com > tmp_ip

HEALTHCHECK --interval=5s --timeout=3s CMD curl $(cat tmp_ip):2020