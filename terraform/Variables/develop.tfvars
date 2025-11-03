project_name = "cloud-office-dev"
bucket_name  = "dev-cloud-office-telecom-website-2024"

versioning_enabled = true
ipv6_enabled       = false
cloudfront_comment = "DEV - CloudFront distribution for Cloud Office website"
price_class        = "PriceClass_100"

min_ttl     = 0
default_ttl = 300
max_ttl     = 3600

password_policy = {
  minimum_length    = 8
  require_lowercase = true
  require_numbers   = true
  require_symbols   = false
  require_uppercase = true
}

token_validity = {
  access_token  = 1
  id_token      = 1
  refresh_token = 7
}

create_admin_user = true
admin_user = {
  username = "admin@cloudoffice-dev.com"
  email    = "admin@cloudoffice-dev.com"
  password = "DevCloudOffice2025!"
}

tags = {
  finops_cost_center  = "CFT00006"
  info_app            = "cloud-office"
  financial_team      = "JulAGomez@teco.com.ar"
  finops_budget_cod   = "cft-00084"
  sec_confidentiality = "mid"
  finops_business     = "CIO"
  technical_team      = "GPodestaQuiroga@teco.com.ar"
  environment         = "dev"
  info_name           = "cloud-office-website"
  info_cluster        = "cloud-office"
  name                = "cloud-office-dev"
  recurso             = "website"
}
