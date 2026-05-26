set -e

echo "Waiting for frontend availability"

for i in {1..30}; do

  if curl -f http://localhost:8080 > /dev/null 2>&1; then
    echo "Frontend is available"
    exit 0
  fi

  echo "Waiting for frontend..."
  sleep 5

done

echo "Frontend failed to start"
exit 1
