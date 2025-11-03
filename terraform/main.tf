################################################################################################
# ＣＬＯＵＤ ＯＦＦＩＣＥ ＴＥＬＥＣＯＭ ＡＲＧＥＮＴＩＮＡ ＩＮＦＲＡＳＴＲＵＣＴＵＲＥ #
################################################################################################

# S3 Bucket para hosting del sitio web
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Configuración de versionado del bucket
resource "aws_s3_bucket_versioning" "website_versioning" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

# Configuración de cifrado del bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "website_encryption" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueo de acceso público al bucket
resource "aws_s3_bucket_public_access_block" "website_pab" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Origin Access Control para CloudFront
resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = "${var.project_name}-oac"
  description                       = "OAC for ${var.project_name} website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Distribución CloudFront
resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    origin_id                = "S3-${aws_s3_bucket.website_bucket.id}"
  }

  enabled             = true
  is_ipv6_enabled     = var.ipv6_enabled
  comment             = var.cloudfront_comment
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = "S3-${aws_s3_bucket.website_bucket.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.tags
}

# Política del bucket S3 para permitir acceso desde CloudFront
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website_distribution.arn
          }
        }
      }
    ]
  })
}

# Cognito User Pool
resource "aws_cognito_user_pool" "website_user_pool" {
  name = "${var.project_name}-user-pool"

  # Configuración de contraseñas
  password_policy {
    minimum_length    = var.password_policy.minimum_length
    require_lowercase = var.password_policy.require_lowercase
    require_numbers   = var.password_policy.require_numbers
    require_symbols   = var.password_policy.require_symbols
    require_uppercase = var.password_policy.require_uppercase
  }

  # Configuración de atributos
  username_attributes = ["email"]
  
  auto_verified_attributes = ["email"]

  # Configuración de verificación de email
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Código de verificación - ${var.project_name}"
    email_message        = "Tu código de verificación es {####}"
  }

  # Configuración de recuperación de cuenta
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  tags = var.tags
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "website_client" {
  name         = "${var.project_name}-client"
  user_pool_id = aws_cognito_user_pool.website_user_pool.id

  generate_secret                      = false
  prevent_user_existence_errors        = "ENABLED"
  enable_token_revocation             = true
  enable_propagate_additional_user_context_data = false

  # Configuración de flujos de autenticación
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  # Configuración de tokens
  access_token_validity  = var.token_validity.access_token
  id_token_validity     = var.token_validity.id_token
  refresh_token_validity = var.token_validity.refresh_token

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}

# Usuario administrador por defecto
resource "aws_cognito_user" "admin_user" {
  count      = var.create_admin_user ? 1 : 0
  user_pool_id = aws_cognito_user_pool.website_user_pool.id
  username     = var.admin_user.username

  attributes = {
    email          = var.admin_user.email
    email_verified = "true"
  }

  password = var.admin_user.password

  lifecycle {
    ignore_changes = [password]
  }
}
