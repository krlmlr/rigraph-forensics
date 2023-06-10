# rigraph-forensics

Reconstruct igraph object formats for old versions of igraph.

## Running old igraph versions

Version 1.2.4.2 and older (2019-11-27) give the following error on my system:

```
/opt/homebrew/bin/gfortran -fno-optimize-sibling-calls  -fPIC  -Wall -g -O2  -c dgetv0.f -o dgetv0.o
dgetv0.f:404:38:

  367 |           call igraphdvout (logfil, 1, rnorm0, ndigit,
      |                                       2
......
  404 |          call igraphdvout (logfil, n, resid, ndigit,
      |                                      1
```

Trying to install older igraph versions in an Ubuntu 18.04 Docker container.
Build with:

```sh
docker build --platform linux/amd64 -t igraph-forensics-bionic bionic
```

Run container with:

```sh
docker run --rm -ti --platform linux/amd64 -v $(pwd)/bionic:/igraph-forensics igraph-forensics-bionic
```

In the container:

```sh
R -q -f 00-tags.R
R -q -f 01-collect.R
```
