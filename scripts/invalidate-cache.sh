#!/bin/bash

# CloudFront Cache Invalidation Script
# Cloud Office - Telecom Argentina

DISTRIBUTION_ID="E3D5JETERRFUQP"

echo "🔄 Invalidando cache de CloudFront..."

INVALIDATION_ID=$(aws cloudfront create-invalidation \
    --distribution-id $DISTRIBUTION_ID \
    --paths "/*" \
    --query 'Invalidation.Id' \
    --output text)

if [ $? -eq 0 ]; then
    echo "✅ Invalidación creada: $INVALIDATION_ID"
    echo "⏳ Progreso: https://console.aws.amazon.com/cloudfront/home#distribution-settings:$DISTRIBUTION_ID"
else
    echo "❌ Error al crear invalidación"
    exit 1
fi
