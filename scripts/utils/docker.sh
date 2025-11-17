# !/bin/bash

build_dockerfile_with_name() {
    name=$1
    echo "Build Dockerfile called $name"
    docker build -t "$name" .
}

stop_remove_container_with_name() {
    name=$1
    docker stop "$name"
    docker rm "$name"
}
