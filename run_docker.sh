#!/usr/bin/env bash

set -e

case $1 in
    'prod-build')
        echo "Building docker image of Jekyll"
        docker build -t jekyll .

        echo "Building Jekyll site"    
        docker run \
            --volume="$PWD:/app" \
            -e JEKYLL_ENV=prod \
            -t jekyll \
            build
    ;;
    'build')
        echo "Building docker image of Jekyll"
        docker build -t jekyll .

        echo "Building Jekyll site"    
        docker run \
            --volume="$PWD:/app" \
            -t jekyll
    ;;
    'serve')
    docker run \
            --volume="$PWD:/app" \
            -p 4000:4000 \
            -it jekyll serve
    ;;
esac