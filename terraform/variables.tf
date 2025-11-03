################################################################################################
# ＶＡＲＩＡＢＬＥＳ ＣＯＮＦＩＧＵＲＡＴＩＯＮ #
################################################################################################

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  validation {
    condition     = length(var.project_name) > 0
    error_message = "El nombre del proyecto no puede estar vacío."
  }
}

variable "bucket_name" {
  description = "Nombre del bucket S3 para el sitio web"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.bucket_name))
    error_message = "El nombre del bucket debe seguir las convenciones de S3."
  }
}

variable "versioning_enabled" {
  description = "Habilitar versionado en el bucket S3"
  type        = bool
  default     = true
}

variable "ipv6_enabled" {
  description = "Habilitar IPv6 en CloudFront"
  type        = bool
  default     = false
}

variable "cloudfront_comment" {
  description = "Comentario para la distribución CloudFront"
  type        = string
  default     = "CloudFront distribution for Cloud Office website"
}

variable "default_root_object" {
  description = "Objeto raíz por defecto para CloudFront"
  type        = string
  default     = "index.html"
}

variable "allowed_methods" {
  description = "Métodos HTTP permitidos en CloudFront"
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  description = "Métodos HTTP que se cachean en CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "min_ttl" {
  description = "TTL mínimo para cache de CloudFront (segundos)"
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "TTL por defecto para cache de CloudFront (segundos)"
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "TTL máximo para cache de CloudFront (segundos)"
  type        = number
  default     = 86400
}

variable "price_class" {
  description = "Clase de precio para CloudFront"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition = contains([
      "PriceClass_All",
      "PriceClass_200", 
      "PriceClass_100"
    ], var.price_class)
    error_message = "La clase de precio debe ser PriceClass_All, PriceClass_200 o PriceClass_100."
  }
}

variable "password_policy" {
  description = "Política de contraseñas para Cognito"
  type = object({
    minimum_length    = number
    require_lowercase = bool
    require_numbers   = bool
    require_symbols   = bool
    require_uppercase = bool
  })
  default = {
    minimum_length    = 12
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
}

variable "token_validity" {
  description = "Configuración de validez de tokens Cognito"
  type = object({
    access_token  = number
    id_token      = number
    refresh_token = number
  })
  default = {
    access_token  = 24
    id_token      = 24
    refresh_token = 30
  }
}

variable "create_admin_user" {
  description = "Crear usuario administrador por defecto"
  type        = bool
  default     = true
}

variable "admin_user" {
  description = "Configuración del usuario administrador"
  type = object({
    username = string
    email    = string
    password = string
  })
  default = {
    username = "admin@cloudoffice.com"
    email    = "admin@cloudoffice.com"
    password = "CloudOffice2025!Secure#"
  }
  sensitive = true
}

variable "tags" {
  description = "Etiquetas obligatorias para los recursos"
  type        = map(string)
  validation {
    condition = alltrue([
      contains(keys(var.tags), "finops_cost_center"),
      contains(keys(var.tags), "info_app"),
      contains(keys(var.tags), "financial_team"),
      contains(keys(var.tags), "finops_budget_cod"),
      contains(keys(var.tags), "sec_confidentiality"),
      contains(keys(var.tags), "finops_business"),
      contains(keys(var.tags), "technical_team"),
      contains(keys(var.tags), "environment"),
      contains(keys(var.tags), "info_name")
    ])
    error_message = "Faltan tags obligatorios. Requeridos: finops_cost_center, info_app, financial_team, finops_budget_cod, sec_confidentiality, finops_business, technical_team, environment, info_name."
  }
}
