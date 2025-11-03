project_name = "cloud-office-test"
bucket_name  = "test-cloud-office-telecom-website-2024"

versioning_enabled = true
ipv6_enabled       = false
cloudfront_comment = "TEST - CloudFront distribution for Cloud Office website"
price_class        = "PriceClass_100"

min_ttl     = 0
default_ttl = 1800
max_ttl     = 7200

password_policy = {
  minimum_length    = 10
  require_lowercase = true
  require_numbers   = true
  require_symbols   = true
  require_uppercase = true
}

token_validity = {
  access_token  = 8
  id_token      = 8
  refresh_token = 14
}

create_admin_user = true
admin_user = {
  username = "admin@cloudoffice-test.com"
  email    = "admin@cloudoffice-test.com"
  password = "TestCloudOffice2025!"
}

tags = {
  finops_cost_center  = "CFT00006"
  info_app            = "cloud-office"
  financial_team      = "JulAGomez@teco.com.ar"
  finops_budget_cod   = "cft-00084"
  sec_confidentiality = "mid"
  finops_business     = "CIO"
  technical_team      = "GPodestaQuiroga@teco.com.ar"
  environment         = "testing"
  info_name           = "cloud-office-website"
  info_cluster        = "cloud-office"
  name                = "cloud-office-test"
  recurso             = "website"
}
