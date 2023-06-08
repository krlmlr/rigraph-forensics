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

RUN mkdir -p /rlib/{1.0.0,0.5,0.4.5,0.4.4,0.4.3,0.4.2,0.4.1,0.4,0.3.3,0.3.2,0.3.1,0.1.2,0.1.1}

RUN R -q -e 'remotes::install_version("igraph", "1.0.0", lib = "1.0.0")'

# RUN R -q -e 'remotes::install_version("igraph", "0.5", lib = "0.5")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4.5", lib = "0.4.5")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4.4", lib = "0.4.4")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4.3", lib = "0.4.3")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4.2", lib = "0.4.2")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4.1", lib = "0.4.1")'

# RUN R -q -e 'remotes::install_version("igraph", "0.4", lib = "0.4")'

# RUN R -q -e 'remotes::install_version("igraph", "0.3.3", lib = "0.3.3")'

# RUN R -q -e 'remotes::install_version("igraph", "0.3.2", lib = "0.3.2")'

# RUN R -q -e 'remotes::install_version("igraph", "0.3.1", lib = "0.3.1")'

RUN R -q -e 'remotes::install_version("igraph", "0.1.2", lib = "0.1.2")'

RUN R -q -e 'remotes::install_version("igraph", "0.1.1", lib = "0.1.1")'


WORKDIR /igraph-forensics
