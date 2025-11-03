# Arquitectura Cloud Office

## 🏗️ Diagrama de Arquitectura

```
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐    ┌─────────────┐
│   Internet  │───▶│  CloudFront  │───▶│ Origin Access   │───▶│ S3 Bucket   │
│   Users     │    │ Distribution │    │ Control (OAC)   │    │ (Private)   │
└─────────────┘    └──────────────┘    └─────────────────┘    └─────────────┘
                           │
                           ▼
                   ┌──────────────┐
                   │   Cognito    │
                   │  User Pool   │
                   └──────────────┘
```

## 🔧 Componentes

### Amazon S3
- **Bucket:** `cloud-office-telecom-website-2024`
- **Región:** us-east-1
- **Acceso:** Privado (solo via OAC)
- **Función:** Almacenamiento de archivos estáticos

### CloudFront
- **Distribution ID:** `E3D5JETERRFUQP`
- **Domain:** d2owmby6b5740.cloudfront.net
- **SSL:** Certificado automático
- **Función:** CDN global con HTTPS

### Origin Access Control (OAC)
- **ID:** `E1UMR5O7NHBU7I`
- **Tipo:** AWS Signature v4
- **Función:** Acceso seguro S3 → CloudFront

### Amazon Cognito
- **User Pool:** `us-east-1_ozrN70qbK`
- **App Client:** `2ee8s2tlioeelhuli5sfn14p9m`
- **Función:** Autenticación de usuarios

## 🛡️ Seguridad

### Principios Implementados
1. **Principio de Menor Privilegio**
2. **Defensa en Profundidad**
3. **Cifrado en Tránsito**
4. **Acceso Controlado**

### Configuraciones de Seguridad
- S3 bucket completamente privado
- OAC con AWS Signature v4
- HTTPS obligatorio
- Headers de seguridad configurados
- Políticas IAM restrictivas

## 📊 Flujo de Datos

1. **Usuario** accede via HTTPS
2. **CloudFront** recibe la petición
3. **OAC** autentica con S3
4. **S3** sirve el contenido
5. **Cognito** maneja autenticación
6. **CloudFront** entrega respuesta cifrada

## 🔄 Escalabilidad

- **CloudFront:** Escalado automático global
- **S3:** Escalado ilimitado
- **Cognito:** Hasta 50K MAU gratis
- **Serverless:** Sin gestión de servidores
