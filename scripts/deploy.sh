#!/bin/bash

# Cloud Office Deployment Script
# Telecom Argentina - Cloud Office

set -e

echo "🚀 Iniciando despliegue Cloud Office..."

# Variables
BUCKET_NAME="cloud-office-telecom-website-2024"
DISTRIBUTION_ID="E3D5JETERRFUQP"
SOURCE_DIR="./src"

# Verificar AWS CLI
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI no está instalado"
    exit 1
fi

# Verificar credenciales AWS
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ Credenciales AWS no configuradas"
    exit 1
fi

echo "✅ AWS CLI configurado correctamente"

# Sincronizar archivos con S3
echo "📁 Sincronizando archivos con S3..."
aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME --delete

if [ $? -eq 0 ]; then
    echo "✅ Archivos sincronizados correctamente"
else
    echo "❌ Error al sincronizar archivos"
    exit 1
fi

# Invalidar cache de CloudFront
echo "🔄 Invalidando cache de CloudFront..."
INVALIDATION_ID=$(aws cloudfront create-invalidation \
    --distribution-id $DISTRIBUTION_ID \
    --paths "/*" \
    --query 'Invalidation.Id' \
    --output text)

if [ $? -eq 0 ]; then
    echo "✅ Invalidación creada: $INVALIDATION_ID"
    echo "⏳ La invalidación puede tardar 5-15 minutos en completarse"
else
    echo "❌ Error al crear invalidación"
    exit 1
fi

echo ""
echo "🎉 Despliegue completado exitosamente!"
echo "🌐 Sitio: https://d2owmby6b5740.cloudfront.net"
echo "📊 Monitoreo: https://console.aws.amazon.com/cloudfront/home#distribution-settings:$DISTRIBUTION_ID"
echo ""
