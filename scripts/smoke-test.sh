#!/bin/bash

set -e

echo "Testing frontend endpoint..."

curl -f http://localhost:8080 > /dev/null

echo "Frontend smoke test passed"
