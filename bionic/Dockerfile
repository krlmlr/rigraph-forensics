FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y

# Installation
RUN apt-get install -y curl parallel

RUN echo "will cite" | parallel --citation

RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | tar xz -C /usr/local

RUN rig add

RUN mkdir -p ~/.R && echo "MAKEFLAGS = -j4" >> ~/.R/Makevars

RUN R -q -e 'pak::pak(c("purrr", "tibblify", "gh", "dplyr", "callr", "tidyverse"))'

# Running
RUN mkdir -p /rlib

RUN R -q -e 'pak::pak("igraph@1.4.3", lib = "/rlib/1.4.3")'

RUN R -q -e 'pak::pak("igraph@1.4.2", lib = "/rlib/1.4.2")'

RUN R -q -e 'pak::pak("igraph@1.4.1", lib = "/rlib/1.4.1")'

RUN R -q -e 'pak::pak("igraph@1.4.0", lib = "/rlib/1.4.0")'

RUN R -q -e 'pak::pak("igraph@1.3.5", lib = "/rlib/1.3.5")'

RUN R -q -e 'pak::pak("igraph@1.3.4", lib = "/rlib/1.3.4")'

RUN R -q -e 'pak::pak("igraph@1.3.3", lib = "/rlib/1.3.3")'

RUN R -q -e 'pak::pak("igraph@1.3.2", lib = "/rlib/1.3.2")'

RUN R -q -e 'pak::pak("igraph@1.3.1", lib = "/rlib/1.3.1")'

RUN R -q -e 'pak::pak("igraph@1.3.0", lib = "/rlib/1.3.0")'

RUN R -q -e 'pak::pak("igraph@1.2.11", lib = "/rlib/1.2.11")'

RUN R -q -e 'pak::pak("igraph@1.2.10", lib = "/rlib/1.2.10")'

RUN R -q -e 'pak::pak("igraph@1.2.9", lib = "/rlib/1.2.9")'

RUN R -q -e 'pak::pak("igraph@1.2.8", lib = "/rlib/1.2.8")'

RUN R -q -e 'pak::pak("igraph@1.2.7", lib = "/rlib/1.2.7")'

RUN R -q -e 'pak::pak("igraph@1.2.6", lib = "/rlib/1.2.6")'

RUN R -q -e 'pak::pak("igraph@1.2.5", lib = "/rlib/1.2.5")'

RUN R -q -e 'pak::pak("igraph@1.2.4.2", lib = "/rlib/1.2.4.2")'

RUN R -q -e 'pak::pak("igraph@1.2.4.1", lib = "/rlib/1.2.4.1")'

RUN R -q -e 'pak::pak("igraph@1.2.4", lib = "/rlib/1.2.4")'

RUN R -q -e 'pak::pak("igraph@1.2.3", lib = "/rlib/1.2.3")'

RUN R -q -e 'pak::pak("igraph@1.2.2", lib = "/rlib/1.2.2")'

RUN R -q -e 'pak::pak("igraph@1.2.1", lib = "/rlib/1.2.1")'

RUN R -q -e 'pak::pak("igraph@1.1.2", lib = "/rlib/1.1.2")'

RUN R -q -e 'pak::pak("igraph@1.1.1", lib = "/rlib/1.1.1")'

RUN R -q -e 'pak::pak("igraph@1.0.1", lib = "/rlib/1.0.1")'

RUN R -q -e 'pak::pak("igraph@0.7.1", lib = "/rlib/0.7.1")'

RUN R -q -e 'pak::pak("igraph@0.7.0", lib = "/rlib/0.7.0")'

RUN R -q -e 'pak::pak("igraph@0.6.6", lib = "/rlib/0.6.6")'

RUN R -q -e 'pak::pak("igraph@0.6.5", lib = "/rlib/0.6.5")'

RUN R -q -e 'pak::pak("igraph@0.6.5-2", lib = "/rlib/0.6.5-2")'

RUN R -q -e 'pak::pak("igraph@0.6.5-1", lib = "/rlib/0.6.5-1")'

RUN R -q -e 'pak::pak("igraph@0.6.4", lib = "/rlib/0.6.4")'

RUN R -q -e 'pak::pak("igraph@0.6", lib = "/rlib/0.6")'

RUN R -q -e 'pak::pak("igraph@0.6-3", lib = "/rlib/0.6-3")'

RUN R -q -e 'pak::pak("igraph@0.6-2", lib = "/rlib/0.6-2")'

RUN R -q -e 'pak::pak("igraph@0.6-1", lib = "/rlib/0.6-1")'

RUN R -q -e 'pak::pak("igraph@0.5.5", lib = "/rlib/0.5.5")'

RUN R -q -e 'pak::pak("igraph@0.5.5-4", lib = "/rlib/0.5.5-4")'

RUN R -q -e 'pak::pak("igraph@0.5.5-3", lib = "/rlib/0.5.5-3")'

RUN R -q -e 'pak::pak("igraph@0.5.5-2", lib = "/rlib/0.5.5-2")'

RUN R -q -e 'pak::pak("igraph@0.5.5-1", lib = "/rlib/0.5.5-1")'

RUN R -q -e 'pak::pak("igraph@0.5.4", lib = "/rlib/0.5.4")'

RUN R -q -e 'pak::pak("igraph@0.5.4-1", lib = "/rlib/0.5.4-1")'

RUN R -q -e 'pak::pak("igraph@0.5.3", lib = "/rlib/0.5.3")'

RUN R -q -e 'pak::pak("igraph@0.5.2", lib = "/rlib/0.5.2")'

RUN R -q -e 'pak::pak("igraph@0.5.2-2", lib = "/rlib/0.5.2-2")'

RUN R -q -e 'pak::pak("igraph@0.5.1", lib = "/rlib/0.5.1")'

RUN R -q -e 'pak::pak("igraph@0.2.1", lib = "/rlib/0.2.1")'

RUN R -q -e 'pak::pak("igraph@0.2", lib = "/rlib/0.2")'

# Get dependencies in place before messing with the system headers
RUN R -q -e 'try(pak::pak("igraph@1.0.0", lib = "/rlib/1.0.0"))'

COPY "usr-include.patch" /

RUN cd /usr/include && patch -p1 < /usr-include.patch

RUN R -q -e 'pak::pak("igraph@1.0.0", lib = "/rlib/1.0.0")'

RUN R -q -e 'pak::pak("igraph@0.5", lib = "/rlib/0.5")'

RUN R -q -e 'pak::pak("igraph@0.4.5", lib = "/rlib/0.4.5")'

RUN R -q -e 'pak::pak("igraph@0.4.4", lib = "/rlib/0.4.4")'

RUN R -q -e 'pak::pak("igraph@0.4.3", lib = "/rlib/0.4.3")'

RUN R -q -e 'pak::pak("igraph@0.4.2", lib = "/rlib/0.4.2")'

RUN R -q -e 'pak::pak("igraph@0.4.1", lib = "/rlib/0.4.1")'

RUN R -q -e 'pak::pak("igraph@0.4", lib = "/rlib/0.4")'

RUN R -q -e 'pak::pak("igraph@0.3.3", lib = "/rlib/0.3.3")'

RUN R -q -e 'pak::pak("igraph@0.3.2", lib = "/rlib/0.3.2")'

RUN R -q -e 'pak::pak("igraph@0.3.1", lib = "/rlib/0.3.1")'

RUN R -q -e 'pak::pak("igraph@0.1.2", lib = "/rlib/0.1.2")'

RUN R -q -e 'pak::pak("igraph@0.1.1", lib = "/rlib/0.1.1")'

# Undo patch before installing dev version
RUN cd /usr/include && patch -p1 -R < /usr-include.patch

RUN R -q -e 'pak::pak("igraph/rigraph@1e851bafb0097451594ae0e8c7cf96a827b75754", lib = "/rlib/1.5.0")'

RUN ls /rlib | parallel -q R -q -e '.libPaths(normalizePath("/rlib/{}")); packageVersion("igraph"); library(igraph)' || true

WORKDIR /igraph-forensics
