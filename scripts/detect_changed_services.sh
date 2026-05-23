#!/bin/bash

set -e

SERVICES=()

if [[ "$GITHUB_EVENT_NAME" == "pull_request" ]]; then
    BASE_REF="origin/${GITHUB_BASE_REF}"
else
    BASE_REF="HEAD~1"
fi

echo "Using base ref: $BASE_REF"

CHANGED_FILES=$(git diff --name-only ${BASE_REF}...HEAD)

echo "Changed files:"
echo "$CHANGED_FILES"

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

if [ ${#SERVICES[@]} -eq 0 ]; then
  JSON="[]"
else
  JSON=$(printf '%s\n' "${SERVICES[@]}" | jq -R . | jq -cs .)
fi

echo "Detected services: $JSON"

echo "matrix=$JSON" >> "$GITHUB_OUTPUT"
