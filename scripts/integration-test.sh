#!/bin/bash

set -e

echo "Testing frontend -> productcatalogservice"
docker exec frontend nc -z productcatalogservice 3550

echo "Testing frontend -> recommendationservice"
docker exec frontend nc -z recommendationservice 8081

echo "Testing cartservice -> redis"
docker exec cart_service nc -z redis-cache 6379

echo "Testing checkoutservice -> paymentservice"
docker exec checkout_service nc -z paymentservice 50051

echo "Testing checkoutservice -> shippingservice"
docker exec checkout_service nc -z shippingservice 50051

echo "Testing checkoutservice -> emailservice"
docker exec checkout_service nc -z emailservice 8080

echo "Integration tests passed"
