#! /usr/bin/bash

BASE=${HOME}/blog
IMG=jekyll
HOST=localhost
PORT=4000:4000

[ -d ${BASE} ] || mkdir -p ${BASE}

podman run -it --rm                               \
  -v ${BASE}/pages:/srv/jekyll:rw,z               \
  -e JEKYLL_UID=$(id -u)  -e JEKYLL_GID=$(id -g)  \
  --publish ${PORT}                               \
  ${IMG}                                          \
 bundle exec jekyll serve --drafts --host=${HOST}


