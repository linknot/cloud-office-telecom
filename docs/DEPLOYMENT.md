# Guía de Despliegue

## 🚀 Despliegue Automático

### Opción 1: Script Automatizado
```bash
./scripts/deploy.sh
```

### Opción 2: Comandos Manuales

#### 1. Sincronizar con S3
```bash
aws s3 sync ./src/ s3://cloud-office-telecom-website-2024 --delete
```

#### 2. Invalidar Cache
```bash
aws cloudfront create-invalidation --distribution-id E3D5JETERRFUQP --paths "/*"
```

## 🔧 Configuración Inicial

### Prerrequisitos
- AWS CLI instalado y configurado
- Permisos para S3, CloudFront y Cognito
- Acceso a la cuenta AWS 118349890720

### Verificar Configuración
```bash
# Verificar credenciales
aws sts get-caller-identity

# Verificar acceso a S3
aws s3 ls s3://cloud-office-telecom-website-2024

# Verificar CloudFront
aws cloudfront get-distribution --id E3D5JETERRFUQP
```

## 🛠️ Configuración de Recursos AWS

### S3 Bucket Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::cloud-office-telecom-website-2024/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::118349890720:distribution/E3D5JETERRFUQP"
        }
      }
    }
  ]
}
```

### CloudFront Origin Access Control
```json
{
  "Id": "E1UMR5O7NHBU7I",
  "Name": "cloud-office-oac",
  "SigningBehavior": "always",
  "SigningProtocol": "sigv4"
}
```

## 🔄 Proceso de CI/CD

### Flujo Recomendado
1. **Desarrollo local**
2. **Commit a GitHub**
3. **Ejecutar deploy script**
4. **Verificar en producción**

### Automatización Futura
- GitHub Actions para deploy automático
- Testing automatizado
- Rollback automático en caso de errores

## 📊 Monitoreo Post-Despliegue

### Verificaciones
- [ ] Sitio carga correctamente
- [ ] HTTPS funciona
- [ ] Autenticación Cognito operativa
- [ ] Todas las secciones visibles
- [ ] Responsive design funcional

### Métricas a Monitorear
- Tiempo de respuesta
- Errores 4xx/5xx
- Tráfico de usuarios
- Uso de ancho de banda

## 🚨 Troubleshooting

### Problemas Comunes

#### Sitio no carga
1. Verificar estado CloudFront
2. Revisar configuración DNS
3. Validar certificado SSL

#### Contenido no actualiza
1. Ejecutar invalidación de cache
2. Verificar sincronización S3
3. Limpiar cache del navegador

#### Error de autenticación
1. Verificar Cognito User Pool
2. Revisar configuración App Client
3. Validar políticas IAM
