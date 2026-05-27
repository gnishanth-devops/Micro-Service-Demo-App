#!/bin/bash

set -e

NETWORK=$(docker network ls --format '{{.Name}}' | grep '_boutique-network')

check_connection() {

  SOURCE=$1
  TARGET=$2
  PORT=$3

  echo "Testing ${SOURCE} -> ${TARGET}:${PORT}"

  docker run --rm \
    --network $NETWORK \
    alpine:3.22 \
    sh -c "
      apk add --no-cache netcat-openbsd >/dev/null &&
      nc -z ${TARGET} ${PORT}
    "

}

check_connection frontend productcatalogservice 3550

check_connection frontend recommendationservice 8081

check_connection cart_service redis-cache 6379

check_connection checkout_service paymentservice 50051

check_connection checkout_service shippingservice 50052

check_connection checkout_service emailservice 8082

echo "Integration tests passed"
