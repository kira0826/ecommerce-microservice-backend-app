#!/usr/bin/env bash
# curl-status-check.sh - Script to GET multiple services and print HTTP status codes with success/failure indication

urls=(
  "http://localhost:8080/app/api/products"
  "http://localhost:8600/shipping-service/api/shippings"
  "http://localhost:8700/user-service/api/users"
  "http://localhost:8500/product-service/api/products"
  "http://localhost:8800/favourite-service/api/favourites"
  "http://localhost:8400/payment-service/api/payments"
)

for url in "${urls[@]}"; do
  echo "=== GET $url ==="
  # Ejecuta la petición y captura solo el código de estado HTTP
  http_status=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Content-Type: application/json" \
    "$url")

  # Imprime el código de estado
  echo "HTTP Status: $http_status"

  # Indica si la petición tuvo éxito (2xx) o falló
  if [[ $http_status -ge 200 && $http_status -lt 300 ]]; then
    echo "✅ Success"
  else
    echo "❌ Failed"
  fi

  echo    

done
