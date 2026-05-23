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

if echo "$CHANGED_FILES" | grep -q '^src/checkout_service/'; then
  SERVICES+=("checkoutservice")
fi

if echo "$CHANGED_FILES" | grep -q '^src/shipping_service/'; then
  SERVICES+=("shipping_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/product_catalog_service/'; then
  SERVICES+=("product_catalog_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/cart_service/'; then
  SERVICES+=("cart_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/payment_service/'; then
  SERVICES+=("payment_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/currency_service/'; then
  SERVICES+=("currency_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/recommendation_service/'; then
  SERVICES+=("recommendation_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/email_service/'; then
  SERVICES+=("email_service")
fi

if echo "$CHANGED_FILES" | grep -q '^src/ad_service/'; then
  SERVICES+=("ad_service")
fi

if [ ${#SERVICES[@]} -eq 0 ]; then
  JSON="[]"
else
  JSON=$(printf '%s\n' "${SERVICES[@]}" | jq -R . | jq -cs .)
fi

echo "Detected services: $JSON"

echo "matrix=$JSON" >> "$GITHUB_OUTPUT"
