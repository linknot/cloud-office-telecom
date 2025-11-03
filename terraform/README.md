# 🏗️ Terraform Infrastructure - Cloud Office

Infraestructura como código para el sitio web Cloud Office de Telecom Argentina usando Terraform.

## 📋 Arquitectura

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

## 🔧 Recursos Creados

| Recurso | Descripción | Configuración |
|---------|-------------|---------------|
| **S3 Bucket** | Almacenamiento privado del sitio | Versionado, cifrado, sin acceso público |
| **CloudFront** | CDN global con HTTPS | OAC, cache optimizado, certificado SSL |
| **Origin Access Control** | Acceso seguro S3 ↔ CloudFront | AWS Signature v4 |
| **Cognito User Pool** | Autenticación de usuarios | Políticas de contraseña, tokens configurables |
| **Cognito User Pool Client** | Cliente de aplicación | Flujos de auth configurados |
| **Cognito User** | Usuario administrador | Credenciales por defecto |

## 🚀 Uso Rápido

### Prerrequisitos
- Terraform >= 1.0
- AWS CLI configurado
- Credenciales AWS válidas

### Deployment

```bash
# 1. Ir al directorio terraform
cd terraform/

# 2. Desplegar en desarrollo
./deploy.sh develop plan
./deploy.sh develop apply

# 3. Desplegar en producción
./deploy.sh master plan
./deploy.sh master apply
```

## 📁 Estructura

```
terraform/
├── main.tf                     # Recursos principales
├── variables.tf                # Variables de entrada
├── outputs.tf                  # Outputs del módulo
├── provider.tf                 # Configuración de providers
├── deploy.sh                   # Script de deployment
├── README.md                   # Esta documentación
└── environments/               # Configuraciones por ambiente
    ├── develop/
    │   └── terraform.tfvars    # Variables de desarrollo
    ├── testing/
    │   └── terraform.tfvars    # Variables de testing
    └── master/
        └── terraform.tfvars    # Variables de producción
```

## 🌍 Ambientes

### Development
- **Bucket:** `dev-cloud-office-telecom-website-2024`
- **Cache TTL:** Corto (5 min - 1 hora)
- **Price Class:** PriceClass_100 (US, Canada, Europa)
- **Cognito:** Políticas relajadas para desarrollo

### Testing
- **Bucket:** `test-cloud-office-telecom-website-2024`
- **Cache TTL:** Medio (30 min - 2 horas)
- **Price Class:** PriceClass_100
- **Cognito:** Políticas intermedias

### Production (Master)
- **Bucket:** `cloud-office-telecom-website-2024`
- **Cache TTL:** Optimizado (1 hora - 24 horas)
- **Price Class:** PriceClass_All (distribución global)
- **Cognito:** Políticas de seguridad altas

## 🔧 Comandos Terraform

### Comandos Básicos
```bash
# Inicializar
terraform init

# Planificar cambios
terraform plan -var-file="environments/develop/terraform.tfvars"

# Aplicar cambios
terraform apply -var-file="environments/develop/terraform.tfvars"

# Ver outputs
terraform output

# Destruir recursos
terraform destroy -var-file="environments/develop/terraform.tfvars"
```

### Gestión de Workspaces
```bash
# Listar workspaces
terraform workspace list

# Crear workspace
terraform workspace new develop

# Cambiar workspace
terraform workspace select develop

# Ver workspace actual
terraform workspace show
```

## 📊 Variables Principales

| Variable | Descripción | Tipo | Requerida |
|----------|-------------|------|-----------|
| `project_name` | Nombre del proyecto | string | ✅ |
| `bucket_name` | Nombre del bucket S3 | string | ✅ |
| `versioning_enabled` | Habilitar versionado S3 | bool | ❌ |
| `cloudfront_comment` | Comentario CloudFront | string | ❌ |
| `price_class` | Clase de precio CloudFront | string | ❌ |
| `password_policy` | Política de contraseñas Cognito | object | ❌ |
| `admin_user` | Usuario administrador | object | ❌ |
| `tags` | Tags obligatorios | map(string) | ✅ |

## 📤 Outputs Importantes

| Output | Descripción |
|--------|-------------|
| `website_url` | URL del sitio web |
| `cloudfront_distribution_id` | ID de CloudFront para invalidaciones |
| `s3_bucket_name` | Nombre del bucket para deployment |
| `cognito_user_pool_id` | ID del User Pool |
| `cognito_client_id` | ID del cliente Cognito |

## 🔐 Seguridad

### Características Implementadas
- ✅ S3 bucket completamente privado
- ✅ Origin Access Control con AWS Signature v4
- ✅ HTTPS obligatorio via CloudFront
- ✅ Políticas de contraseña configurables
- ✅ Tokens con validez configurable
- ✅ Tags obligatorios para governance

### Validaciones
- Nombres de bucket siguen convenciones S3
- Tags obligatorios están presentes
- Políticas de contraseña son seguras
- Price class es válida

## 💰 Costos Estimados

| Ambiente | Costo Mensual Estimado |
|----------|----------------------|
| **Development** | $1-5 USD |
| **Testing** | $2-8 USD |
| **Production** | $5-15 USD |

### Desglose por Servicio
- **S3:** ~$0.023/GB + $0.0004/1K requests
- **CloudFront:** ~$0.085/GB + $0.0075/10K requests
- **Cognito:** Gratis hasta 50K MAU

## 🚨 Troubleshooting

### Errores Comunes

#### Error: Bucket ya existe
```bash
# Importar bucket existente
terraform import aws_s3_bucket.website_bucket nombre-del-bucket
```

#### Error: Workspace no existe
```bash
# Crear workspace
terraform workspace new develop
```

#### Error: Tags faltantes
Verificar que todos los tags obligatorios están en `terraform.tfvars`:
- `finops_cost_center`
- `info_app`
- `financial_team`
- `finops_budget_cod`
- `sec_confidentiality`
- `finops_business`
- `technical_team`
- `environment`
- `info_name`

## 📞 Soporte

- **Documentación:** Ver `/docs` en el repositorio
- **Issues:** Crear issue en GitHub
- **Contacto:** cloudoffice@teco.com.ar

---

**🏗️ Infraestructura como Código - Cloud Office Telecom Argentina**
