#!/bin/bash

# Fetch the latest release tag
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)

echo "Checking out latest release: $latest_tag"
git checkout $latest_tag

# Build and run the Docker container
docker build -t python-web-app:$latest_tag .
docker run -d -p 5000:5000 --name python-web-app python-web-app:$latest_tag

# Print container IP
container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' python-web-app)
echo "Container IP: $container_ip"
