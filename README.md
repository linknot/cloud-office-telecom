# ☁️ Cloud Office - Telecom Argentina

> Sitio web corporativo para la tribu Cloud Office de Telecom Argentina. Arquitectura serverless segura en AWS con S3, CloudFront y Cognito.

[![AWS](https://img.shields.io/badge/AWS-Cloud-orange)](https://aws.amazon.com)
[![Status](https://img.shields.io/badge/Status-Production-green)](https://d2owmby6b5740.cloudfront.net)
[![Security](https://img.shields.io/badge/Security-OAC%20Enabled-blue)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)

## 🌐 Demo

**🔗 Sitio en vivo:** https://d2owmby6b5740.cloudfront.net

## 📋 Descripción

Sitio web corporativo moderno para Cloud Office de Telecom Argentina, implementado con arquitectura serverless segura en AWS. Incluye autenticación, infografías interactivas y contenido dinámico sobre la organización y servicios cloud.

### ✨ Características

- 🏠 **Hero Section** animado con branding corporativo
- 📚 **Gestión del Conocimiento** - CSX, certificaciones, novedades
- 🤝 **Cultura y Comunicación** - Onboarding, foros, métricas  
- ⚙️ **Modelo Operativo** - Scrum of Scrums, CBO, Platform Engineering
- 🔐 **Autenticación** con Amazon Cognito
- 📱 **Responsive Design** para todos los dispositivos
- 🛡️ **Arquitectura Segura** con Origin Access Control

## 🏗️ Arquitectura AWS

```
Internet → CloudFront → Origin Access Control → S3 Bucket (Privado)
                    ↓
                Cognito User Pool
```

### 🔧 Recursos Implementados

| Servicio | ID | Función |
|----------|----|---------| 
| **S3 Bucket** | `cloud-office-telecom-website-2024` | Almacenamiento privado |
| **CloudFront** | `E3D5JETERRFUQP` | CDN global con HTTPS |
| **Origin Access Control** | `E1UMR5O7NHBU7I` | Acceso seguro |
| **Cognito User Pool** | `us-east-1_ozrN70qbK` | Autenticación |

## 🚀 Despliegue

### Prerrequisitos

- AWS CLI configurado
- Permisos para S3, CloudFront y Cognito
- Cuenta AWS activa

### Instalación

1. **Clonar repositorio**
```bash
git clone https://github.com/linknot/cloud-office-telecom.git
cd cloud-office-telecom
```

2. **Subir archivos a S3**
```bash
aws s3 sync ./src/ s3://cloud-office-telecom-website-2024
```

3. **Invalidar cache CloudFront**
```bash
aws cloudfront create-invalidation --distribution-id E3D5JETERRFUQP --paths "/*"
```

## 📁 Estructura del Proyecto

```
cloud-office-telecom/
├── README.md                    # Este archivo
├── src/                         # Código fuente del sitio
│   ├── index.html              # Página principal
│   ├── styles.css              # Estilos CSS
│   └── app.js                  # JavaScript + Cognito
├── docs/                       # Documentación
│   ├── ARCHITECTURE.md         # Documentación técnica
│   ├── DEPLOYMENT.md           # Guía de despliegue
│   └── CONFLUENCE.md           # Documentación para Confluence
├── aws/                        # Configuraciones AWS
│   ├── cloudfront-config.json  # Configuración CloudFront
│   ├── bucket-policy.json      # Política S3
│   └── cognito-config.json     # Configuración Cognito
└── scripts/                    # Scripts de automatización
    ├── deploy.sh               # Script de despliegue
    └── invalidate-cache.sh     # Invalidación de cache
```

## 🛡️ Seguridad

- ✅ **S3 Bucket Privado** - Sin acceso público directo
- ✅ **Origin Access Control** - AWS Signature v4
- ✅ **HTTPS Obligatorio** - Certificado SSL automático
- ✅ **Autenticación Cognito** - Contraseñas seguras
- ✅ **Headers de Seguridad** - HSTS, X-Frame-Options

## 💰 Costos

| Servicio | Costo Mensual Estimado |
|----------|----------------------|
| S3 | $1-5 USD |
| CloudFront | $1-10 USD |
| Cognito | Gratis (< 50K MAU) |
| **Total** | **$2-15 USD/mes** |

## 🔧 Mantenimiento

### Actualizar Contenido
```bash
# Sincronizar archivos
aws s3 sync ./src/ s3://cloud-office-telecom-website-2024

# Invalidar cache
aws cloudfront create-invalidation --distribution-id E3D5JETERRFUQP --paths "/*"
```

### Monitoreo
- **CloudWatch** - Métricas de infraestructura
- **CloudFront Reports** - Análisis de tráfico  
- **Cognito Analytics** - Estadísticas de usuarios

## 📞 Contacto

- **Email:** cloudoffice@teco.com.ar
- **Proyecto:** Cloud Office - Telecom Argentina
- **Arquitecto:** Amazon Q Developer

## 📄 Licencia

Este proyecto es propiedad de Telecom Argentina - Cloud Office.

## 🚀 Roadmap

- [ ] Migración a React + TypeScript
- [ ] Implementación con AWS Amplify Gen 2
- [ ] Analytics avanzados con QuickSight
- [ ] APIs backend con Lambda

---

**⭐ Si te gusta el proyecto, dale una estrella!**
