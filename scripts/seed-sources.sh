#!/bin/sh
# Copies ePub files from ./sources into the Docker volume.
# Run this after `docker compose up -d` to populate the sources volume.
#
# Usage: ./scripts/seed-sources.sh

set -e

CONTAINER=$(docker compose ps -q app)
if [ -z "$CONTAINER" ]; then
    echo "Error: app container is not running. Start it with: docker compose up -d"
    exit 1
fi

echo "Copying ePub files into the app container's /data/sources..."
for epub in sources/*.epub; do
    if [ -f "$epub" ]; then
        docker cp "$epub" "$CONTAINER":/data/sources/
        echo "  Copied $(basename "$epub")"
    fi
done

echo "Done. ePub files are now available in the sources volume."
