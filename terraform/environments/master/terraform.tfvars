# ================================================================================================
# ＭＡＳＴＥＲ (ＰＲＯＤＵＣＴＩＯＮ) ＥＮＶＩＲＯＮＭＥＮＴ ＣＯＮＦＩＧＵＲＡＴＩＯＮ
# ================================================================================================

project_name = "cloud-office"
bucket_name  = "cloud-office-telecom-website-2024"

# Configuración de S3
versioning_enabled = true

# Configuración de CloudFront
ipv6_enabled         = false
cloudfront_comment   = "PROD - CloudFront distribution for Cloud Office Telecom Argentina"
default_root_object  = "index.html"
price_class         = "PriceClass_All"  # Distribución global completa

# Configuración de cache (producción - cache optimizado)
min_ttl     = 0
default_ttl = 3600   # 1 hora
max_ttl     = 86400  # 24 horas

# Configuración de Cognito (producción - seguridad alta)
password_policy = {
  minimum_length    = 12
  require_lowercase = true
  require_numbers   = true
  require_symbols   = true
  require_uppercase = true
}

token_validity = {
  access_token  = 24   # 24 horas
  id_token      = 24   # 24 horas
  refresh_token = 30   # 30 días
}

# Usuario administrador
create_admin_user = true
admin_user = {
  username = "admin@cloudoffice.com"
  email    = "admin@cloudoffice.com"
  password = "CloudOffice2025!Secure#"
}

# Tags obligatorios
tags = {
  finops_cost_center  = "CFT00006"
  info_app            = "cloud-office"
  financial_team      = "JulAGomez@teco.com.ar"
  finops_budget_cod   = "cft-00084"
  sec_confidentiality = "mid"
  finops_business     = "CIO"
  technical_team      = "GPodestaQuiroga@teco.com.ar"
  environment         = "master"
  info_name           = "cloud-office-website"
  info_cluster        = "cloud-office"
  name                = "cloud-office-prod"
  recurso             = "website"
}
