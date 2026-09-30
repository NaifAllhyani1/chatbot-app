#!/bin/bash
set -e

# Always run from the folder this script lives in (the cloned repo)
cd "$(dirname "$0")"

# Pull the latest code (compose file, this script) using the GitHub deploy key
GIT_SSH_COMMAND='ssh -i /home/azureuser/.ssh/github_deploy -o IdentitiesOnly=yes' git pull

# Pull the newest images from Docker Hub and restart
docker compose pull
docker compose up -d

# Remove old, unused images to save disk space
docker image prune -f