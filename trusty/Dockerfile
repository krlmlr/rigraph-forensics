FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl

RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | tar xz -C /usr/local

RUN rig add

RUN R -q -e 'pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr"))'

RUN mkdir -p ~/.R && echo "MAKEFLAGS = -j4" >> ~/.R/Makevars

WORKDIR /igraph-forensics
