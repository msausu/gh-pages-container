#! /usr/bin/bash

IMG=jekyll

buildah bud -t ${IMG} .

