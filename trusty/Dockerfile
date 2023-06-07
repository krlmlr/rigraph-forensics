FROM ubuntu:14.04

RUN rm /etc/apt/sources.list.d/ubuntu-esm-infra-trusty.list && apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y software-properties-common wget dirmngr

RUN add-apt-repository "deb http://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"

RUN apt-get update

RUN apt-get install -y --force-yes r-base

RUN locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN echo 'options(\n\
  repos = c(CRAN = "https://cloud.r-project.org/")\n\
)' >> /etc/R/Rprofile.site

RUN R -q -e 'install.packages("gh")'

RUN R -q -e 'install.packages("tibblify")'

RUN mkdir -p ~/.R && echo "MAKEFLAGS = -j4" >> ~/.R/Makevars

RUN R -q -e 'install.packages("callr")'

RUN R -q -e 'install.packages("purrr")'

RUN R -q -e 'install.packages("dplyr")'

RUN R -q -e 'install.packages("NMF")'

RUN R -q -e 'install.packages("irlba")'

RUN R -q -e 'install.packages("BiocManager")'

RUN R -q -e 'BiocManager::install("Biobase", update = FALSE)'

RUN R -q -e 'install.packages("NMF")'

RUN R -q -e 'install.packages("remotes")'

WORKDIR /igraph-forensics
