################################################################################################
# ＯＵＴＰＵＴＳ ＣＯＮＦＩＧＵＲＡＴＩＯＮ #
################################################################################################

output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.website_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.website_bucket.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name del bucket S3"
  value       = aws_s3_bucket.website_bucket.bucket_domain_name
}

output "cloudfront_distribution_id" {
  description = "ID de la distribución CloudFront"
  value       = aws_cloudfront_distribution.website_distribution.id
}

output "cloudfront_distribution_arn" {
  description = "ARN de la distribución CloudFront"
  value       = aws_cloudfront_distribution.website_distribution.arn
}

output "cloudfront_domain_name" {
  description = "Domain name de CloudFront"
  value       = aws_cloudfront_distribution.website_distribution.domain_name
}

output "website_url" {
  description = "URL del sitio web"
  value       = "https://${aws_cloudfront_distribution.website_distribution.domain_name}"
}

output "origin_access_control_id" {
  description = "ID del Origin Access Control"
  value       = aws_cloudfront_origin_access_control.website_oac.id
}

output "cognito_user_pool_id" {
  description = "ID del User Pool de Cognito"
  value       = aws_cognito_user_pool.website_user_pool.id
}

output "cognito_user_pool_arn" {
  description = "ARN del User Pool de Cognito"
  value       = aws_cognito_user_pool.website_user_pool.arn
}

output "cognito_user_pool_endpoint" {
  description = "Endpoint del User Pool de Cognito"
  value       = aws_cognito_user_pool.website_user_pool.endpoint
}

output "cognito_client_id" {
  description = "ID del cliente de Cognito"
  value       = aws_cognito_user_pool_client.website_client.id
}

output "admin_user_username" {
  description = "Username del usuario administrador"
  value       = var.create_admin_user ? aws_cognito_user.admin_user[0].username : null
}

# Outputs para scripts de deployment
output "deployment_info" {
  description = "Información para scripts de deployment"
  value = {
    bucket_name      = aws_s3_bucket.website_bucket.id
    distribution_id  = aws_cloudfront_distribution.website_distribution.id
    website_url      = "https://${aws_cloudfront_distribution.website_distribution.domain_name}"
    user_pool_id     = aws_cognito_user_pool.website_user_pool.id
    client_id        = aws_cognito_user_pool_client.website_client.id
  }
}

# Output con información de costos estimados
output "estimated_monthly_costs" {
  description = "Costos mensuales estimados en USD"
  value = {
    s3_storage_gb     = "~$0.023 por GB"
    s3_requests       = "~$0.0004 por 1K requests"
    cloudfront_data   = "~$0.085 por GB (primeros 10TB)"
    cloudfront_requests = "~$0.0075 por 10K requests"
    cognito_mau       = "Gratis hasta 50K MAU"
    total_estimated   = "$2-15 USD/mes (uso típico)"
  }
}
