# 🏗️ Terraform Infrastructure - Cloud Office

Infraestructura como código para el sitio web Cloud Office de Telecom Argentina.

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

## 📁 Estructura

```
terraform/
├── main.tf                     # Recursos principales
├── variables.tf                # Variables de entrada
├── outputs.tf                  # Outputs del módulo
├── provider.tf                 # Configuración de providers
├── README.md                   # Esta documentación
├── .gitignore                  # Archivos a ignorar
└── Variables/                  # Variables por ambiente
    ├── develop.tfvars          # Variables de desarrollo
    ├── testing.tfvars          # Variables de testing
    └── master.tfvars           # Variables de producción
```

## 🚀 Deployment via GitLab CI/CD

El deployment se realiza automáticamente a través de GitLab CI/CD siguiendo el estándar de Telecom:

### Pipeline Stages
1. **Validate** - Validación de sintaxis Terraform
2. **Plan** - Generación del plan de ejecución
3. **Apply** - Aplicación de cambios (manual approval)

### Comandos GitLab
```yaml
# .gitlab-ci.yml (ejemplo)
terraform_plan:
  script:
    - terraform init
    - terraform plan -var-file="Variables/${CI_COMMIT_REF_NAME}.tfvars"

terraform_apply:
  script:
    - terraform apply -var-file="Variables/${CI_COMMIT_REF_NAME}.tfvars" -auto-approve
  when: manual
```

## 🌍 Ambientes

### Development (develop branch)
- **Bucket:** `dev-cloud-office-telecom-website-2024`
- **Cache TTL:** Corto (5 min - 1 hora)
- **Price Class:** PriceClass_100 (US, Canada, Europa)
- **Variables:** `Variables/develop.tfvars`

### Testing (testing branch)
- **Bucket:** `test-cloud-office-telecom-website-2024`
- **Cache TTL:** Medio (30 min - 2 horas)
- **Price Class:** PriceClass_100
- **Variables:** `Variables/testing.tfvars`

### Production (master branch)
- **Bucket:** `cloud-office-telecom-website-2024`
- **Cache TTL:** Optimizado (1 hora - 24 horas)
- **Price Class:** PriceClass_All (distribución global)
- **Variables:** `Variables/master.tfvars`

## 🔧 Comandos Terraform Locales

### Para desarrollo local únicamente
```bash
# Inicializar
terraform init

# Planificar cambios
terraform plan -var-file="Variables/develop.tfvars"

# Aplicar cambios (solo para testing local)
terraform apply -var-file="Variables/develop.tfvars"

# Ver outputs
terraform output
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

## 📞 Soporte

- **Documentación:** Ver `/docs` en el repositorio
- **Issues:** GitLab Issues
- **Contacto:** cloudoffice@teco.com.ar

---

**🏗️ Infraestructura como Código - Cloud Office Telecom Argentina**
