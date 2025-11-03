# Cloud Office - Sitio Web Corporativo

## 📋 Información General

| Campo | Valor |
|-------|-------|
| **Proyecto** | Sitio Web Cloud Office - Telecom Argentina |
| **Fecha Creación** | 24 de Octubre, 2025 |
| **Arquitecto** | Amazon Q Developer |
| **Estado** | ✅ Producción |
| **Versión** | 2.0 (Segura con OAC) |
| **URL Principal** | https://d2owmby6b5740.cloudfront.net |
| **Contacto** | cloudoffice@teco.com.ar |

---

## 🌐 Acceso al Sistema

### URLs de Acceso
- **Sitio Principal:** https://d2owmby6b5740.cloudfront.net
- **Email Contacto:** cloudoffice@teco.com.ar

### Credenciales de Administrador
```
Usuario: admin@cloudoffice.com
Contraseña: CloudOffice2025!Secure#
```

---

## 🏗️ Arquitectura AWS

### Recursos Implementados

| Servicio | Identificador | Función | Estado |
|----------|---------------|---------|--------|
| **Amazon S3** | `cloud-office-telecom-website-2024` | Almacenamiento privado del sitio | ✅ Activo |
| **CloudFront** | `E3D5JETERRFUQP` | CDN global con HTTPS | ✅ Desplegado |
| **Origin Access Control** | `E1UMR5O7NHBU7I` | Control de acceso seguro | ✅ Activo |
| **Cognito User Pool** | `us-east-1_ozrN70qbK` | Autenticación de usuarios | ✅ Activo |
| **Cognito App Client** | `2ee8s2tlioeelhuli5sfn14p9m` | Cliente de aplicación | ✅ Configurado |

### Diagrama de Arquitectura

```
Internet → CloudFront → Origin Access Control → S3 Bucket (Privado)
                    ↓
                Cognito User Pool (Autenticación)
```

---

## 🛡️ Características de Seguridad

### Implementaciones de Seguridad
- ✅ **S3 Bucket Privado:** Sin acceso público directo
- ✅ **Origin Access Control (OAC):** AWS Signature v4
- ✅ **HTTPS Obligatorio:** Certificado SSL via CloudFront
- ✅ **Autenticación Cognito:** Contraseñas seguras
- ✅ **Principio de Menor Privilegio:** Acceso mínimo necesario

### Configuraciones de Seguridad
- **Bucket Policy:** Solo acceso desde CloudFront OAC
- **CloudFront:** Redirect HTTP → HTTPS automático
- **Cognito:** Políticas de contraseña robustas
- **Headers de Seguridad:** HSTS, X-Frame-Options configurados

---

## 📱 Funcionalidades del Sitio

### Secciones Principales
1. **🏠 Hero Section**
   - Bienvenida animada con branding corporativo
   - Call-to-action para explorar contenido

2. **💡 ¿Qué es Cloud Office?**
   - Descripción de la tribu Cloud Office
   - Misión y visión del equipo

3. **🌟 Sección Principal**
   - Videos introductorios
   - Contenido destacado

4. **📚 Gestión del Conocimiento**
   - CSX (Cloud Skills Exchange)
   - Certificaciones AWS/Azure/GCP
   - Novedades tecnológicas

5. **🤝 Cultura y Comunicación**
   - Proceso de onboarding
   - Foros de discusión
   - Métricas y KPIs

6. **⚙️ Modelo Operativo**
   - Scrum of Scrums
   - Cloud Business Office (CBO)
   - Platform Engineering

### Infografía Organizacional
- **Framework de Governance:** 5 pilares (Architecture, Security, Infrastructure, Operations, Financial)
- **Estructura Multicloud:** CBO + Aplicaciones + Cloud Platform Engineering
- **Business Partners:** Grid de clientes y stakeholders

### Sistema de Autenticación
- **Login/Registro:** Integrado con Amazon Cognito
- **Gestión de Usuarios:** Panel administrativo
- **Recuperación de Contraseña:** Flujo automático por email

---

## 🚀 Despliegue y Mantenimiento

### Comandos de Actualización

#### Actualizar Contenido del Sitio
```bash
cd "C:\Users\u605751\Documents\Proyectos\sitio cloud office"
aws s3 sync ./sitio-web/ s3://cloud-office-telecom-website-2024 --profile 118349890720_RENTACCOUNT_ADM
```

#### Invalidar Cache de CloudFront
```bash
aws cloudfront create-invalidation --distribution-id E3D5JETERRFUQP --paths "/*" --profile 118349890720_RENTACCOUNT_ADM
```

#### Verificar Estado de Recursos
```bash
# Verificar CloudFront
aws cloudfront get-distribution --id E3D5JETERRFUQP --profile 118349890720_RENTACCOUNT_ADM

# Verificar S3
aws s3 ls s3://cloud-office-telecom-website-2024 --profile 118349890720_RENTACCOUNT_ADM

# Verificar Cognito
aws cognito-idp describe-user-pool --user-pool-id us-east-1_ozrN70qbK --profile 118349890720_RENTACCOUNT_ADM
```

### Estructura del Repositorio
```
sitio cloud office/
├── README.md                    # Documentación principal
├── sitio-web/                   # Código fuente
│   ├── index.html              # Página principal
│   ├── styles.css              # Estilos CSS
│   └── app.js                  # JavaScript + Cognito
├── cloudfront-config.json      # Configuración CloudFront
├── bucket-policy.json          # Política S3 segura
├── deploy.sh                   # Script de despliegue
└── recursos-aws.md            # Inventario de recursos
```

---

## 💰 Costos y Facturación

### Estimación de Costos Mensuales

| Servicio | Costo Estimado | Descripción |
|----------|----------------|-------------|
| **Amazon S3** | $1-5 USD | Storage + requests |
| **CloudFront** | $1-10 USD | CDN + data transfer |
| **Cognito** | Gratis | Hasta 50,000 MAU |
| **Total** | **$2-15 USD/mes** | Costo operativo bajo |

### Optimizaciones de Costo
- **S3 Intelligent Tiering:** Automático para archivos poco accedidos
- **CloudFront Caching:** Configurado para máxima eficiencia
- **Cognito Free Tier:** Suficiente para uso corporativo interno

---

## 📊 Métricas y Monitoreo

### KPIs del Sitio
- **Disponibilidad:** 99.9% (SLA CloudFront)
- **Tiempo de Carga:** < 2 segundos
- **Usuarios Activos:** Tracking via Cognito
- **Tráfico:** Métricas CloudFront

### Herramientas de Monitoreo
- **CloudWatch:** Métricas de infraestructura
- **CloudFront Reports:** Análisis de tráfico
- **Cognito Analytics:** Estadísticas de usuarios
- **S3 Access Logs:** Logs de acceso detallados

---

## 🔧 Troubleshooting

### Problemas Comunes

#### Sitio No Carga
1. Verificar estado de CloudFront: `aws cloudfront get-distribution --id E3D5JETERRFUQP`
2. Verificar DNS: `nslookup d2owmby6b5740.cloudfront.net`
3. Verificar certificado SSL en navegador

#### Error de Autenticación
1. Verificar Cognito User Pool: `aws cognito-idp describe-user-pool --user-pool-id us-east-1_ozrN70qbK`
2. Verificar configuración del App Client
3. Revisar logs de CloudWatch

#### Contenido No Actualiza
1. Ejecutar invalidación de CloudFront
2. Verificar sincronización con S3
3. Limpiar cache del navegador

### Contactos de Soporte
- **Técnico:** Amazon Q Developer
- **Funcional:** cloudoffice@teco.com.ar
- **AWS Support:** Según plan contratado

---

## 🚀 Roadmap Futuro

### Mejoras Planificadas
- **Migración a React + TypeScript:** Modernización completa del frontend
- **Amplify Gen 2:** Infraestructura serverless avanzada
- **Analytics Avanzados:** Integración con Amazon QuickSight
- **API Backend:** Desarrollo de APIs con Lambda

### Cronograma Sugerido
- **Q1 2025:** Análisis y planificación de migración
- **Q2 2025:** Implementación de React + TypeScript
- **Q3 2025:** Migración a Amplify Gen 2
- **Q4 2025:** Funcionalidades avanzadas y analytics

---

## 📞 Información de Contacto

| Rol | Contacto | Responsabilidad |
|-----|----------|----------------|
| **Product Owner** | cloudoffice@teco.com.ar | Requerimientos funcionales |
| **Arquitecto Técnico** | Amazon Q Developer | Arquitectura y desarrollo |
| **Administrador AWS** | Equipo Cloud Office | Gestión de infraestructura |
| **Soporte Usuarios** | cloudoffice@teco.com.ar | Soporte funcional |

---

## 📚 Enlaces Útiles

- **Sitio Web:** https://d2owmby6b5740.cloudfront.net
- **AWS Console:** https://console.aws.amazon.com
- **Cognito Console:** https://console.aws.amazon.com/cognito
- **CloudFront Console:** https://console.aws.amazon.com/cloudfront
- **S3 Console:** https://console.aws.amazon.com/s3

---

**📅 Última Actualización:** 3 de Noviembre, 2025  
**📝 Versión Documento:** 1.0  
**✅ Estado:** Producción Estable
