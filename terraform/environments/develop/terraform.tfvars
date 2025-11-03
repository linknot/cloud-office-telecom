# ================================================================================================
# ＤＥＶＥＬＯＰ ＥＮＶＩＲＯＮＭＥＮＴ ＣＯＮＦＩＧＵＲＡＴＩＯＮ
# ================================================================================================

project_name = "cloud-office-dev"
bucket_name  = "dev-cloud-office-telecom-website-2024"

# Configuración de S3
versioning_enabled = true

# Configuración de CloudFront
ipv6_enabled         = false
cloudfront_comment   = "DEV - CloudFront distribution for Cloud Office website"
default_root_object  = "index.html"
price_class         = "PriceClass_100"  # Solo US, Canada, Europa

# Configuración de cache (desarrollo - cache corto)
min_ttl     = 0
default_ttl = 300    # 5 minutos
max_ttl     = 3600   # 1 hora

# Configuración de Cognito
password_policy = {
  minimum_length    = 8
  require_lowercase = true
  require_numbers   = true
  require_symbols   = false
  require_uppercase = true
}

token_validity = {
  access_token  = 1    # 1 hora
  id_token      = 1    # 1 hora
  refresh_token = 7    # 7 días
}

# Usuario administrador
create_admin_user = true
admin_user = {
  username = "admin@cloudoffice-dev.com"
  email    = "admin@cloudoffice-dev.com"
  password = "DevCloudOffice2025!"
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
  environment         = "develop"
  info_name           = "cloud-office-website"
  info_cluster        = "cloud-office"
  name                = "cloud-office-dev"
  recurso             = "website"
}
