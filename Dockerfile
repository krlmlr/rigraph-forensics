FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl

RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | tar xz -C /usr/local

RUN rig add
