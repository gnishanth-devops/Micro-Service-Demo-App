#!/bin/bash

set -e
COMPOSE_FILE="compose/docker-compose-integration-dev.yml"

echo "Waiting for compose stack to become healthy..."

for i in {1..30}; do

  FAILED_CONTAINERS=$(docker compose -f $COMPOSE_FILE ps --format json | jq -r '
    .[] | select(
      (.State != "running") or
      (.Health == "unhealthy")
    ) | .Name
  ')

  if [ -z "$FAILED_CONTAINERS" ]; then
    echo "All services are healthy"
    break
  fi

  echo "Still waiting for services..."
  echo "$FAILED_CONTAINERS"

  sleep 10

done

echo "Running frontend smoke test..."

curl -f http://localhost:8080 > /dev/null

echo "Frontend reachable"

echo "Compose integration validation successful"
