#!/bin/bash

set -e

echo "Testing frontend endpoint"

curl -f http://localhost:8080

echo "Frontend smoke test passed"
