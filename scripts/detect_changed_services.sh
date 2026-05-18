#!/bin/bash

set -e

SERVICES=()

CHANGED_FILES=$(git diff --name-only origin/${GITHUB_BASE_REF}...HEAD)

if echo "$CHANGED_FILES" | grep -q '^src/frontend/'; then
  SERVICES+=("frontend")
fi

if echo "$CHANGED_FILES" | grep -q '^src/checkoutservice/'; then
  SERVICES+=("checkoutservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/shippingservice/'; then
  SERVICES+=("shippingservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/productcatalogservice/'; then
  SERVICES+=("productcatalogservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/cartservice/'; then
  SERVICES+=("cartservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/paymentservice/'; then
  SERVICES+=("paymentservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/currencyservice/'; then
  SERVICES+=("currencyservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/recommendationservice/'; then
  SERVICES+=("recommendationservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/emailservice/'; then
  SERVICES+=("emailservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/adservice/'; then
  SERVICES+=("adservice")
fi

JSON=$(printf '%s\n' "${SERVICES[@]}" | jq -R . | jq -cs .)

echo "Detected services: $JSON"

echo "matrix=$JSON" >> $GITHUB_OUTPUT
