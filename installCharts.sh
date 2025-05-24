#!/bin/bash


BASE_DIR="./manifests"

CHARTS=(
  "cloud-config"
  "discovery"
  "zipkin"
  "api-gateway"
  "proxy-client"
  "order-service"
  "payment-service"
  "product-service"
  "shipping-service"
  "user-service"
)

NAMESPACE="default"

for CHART in "${CHARTS[@]}"; do
  echo "🚀 Instalando $CHART..."
  helm upgrade --install "$CHART" "$BASE_DIR/$CHART" --namespace "$NAMESPACE"
  echo ""
done

echo "✅ Todos los Helm charts fueron instalados o actualizados."

