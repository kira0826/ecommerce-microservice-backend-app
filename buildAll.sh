#!/bin/bash

# ⚙️ Configuración
TAG="dev"
SERVICES=(
  "service-discovery"
  "cloud-config"
  "api-gateway"
  "proxy-client"
  "order-service"
  "payment-service"
  "product-service"
  "shipping-service"
  "user-service"
  "favourite-service"
)

# 🔧 Usar el daemon de Docker de Minikube
echo "📡 Cambiando el entorno Docker al de Minikube..."
eval $(minikube docker-env)

# 🔁 Bucle para construir y cargar imágenes
for SERVICE in "${SERVICES[@]}"; do
  echo "🔨 Construyendo imagen para: $SERVICE"
  
  # Verificamos que el Dockerfile exista
  if [[ ! -f "$SERVICE/Dockerfile" ]]; then
    echo "❌ No se encontró Dockerfile en ./$SERVICE — omitiendo"
    continue
  fi

  # Construcción de la imagen
  docker build -t "$SERVICE:$TAG" "./$SERVICE"

  if [[ $? -ne 0 ]]; then
    echo "❌ Falló la construcción de la imagen $SERVICE:$TAG"
    exit 1
  fi

  # Verificación
  echo "✅ Imagen $SERVICE:$TAG construida"
done

# 🔍 Mostrar imágenes construidas
echo "📦 Imágenes locales en Minikube:"
docker images | grep "$TAG"

echo "🎉 ¡Todas las imágenes fueron construidas correctamente!"
