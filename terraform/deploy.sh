#!/bin/bash

# ================================================================================================
# ＣＬＯＵＤ ＯＦＦＩＣＥ ＴＥＲＲＡＦＯＲＭ ＤＥＰＬＯＹＭＥＮＴ ＳＣＲＩＰＴ
# ================================================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar parámetros
if [ $# -eq 0 ]; then
    echo "Uso: $0 <environment> [action]"
    echo ""
    echo "Environments disponibles:"
    echo "  - develop"
    echo "  - testing"
    echo "  - master"
    echo ""
    echo "Actions disponibles:"
    echo "  - plan (default)"
    echo "  - apply"
    echo "  - destroy"
    echo ""
    echo "Ejemplos:"
    echo "  $0 develop plan"
    echo "  $0 master apply"
    echo "  $0 testing destroy"
    exit 1
fi

ENVIRONMENT=$1
ACTION=${2:-plan}

# Validar environment
if [[ ! "$ENVIRONMENT" =~ ^(develop|testing|master)$ ]]; then
    error "Environment inválido. Usar: develop, testing, o master"
fi

# Validar action
if [[ ! "$ACTION" =~ ^(plan|apply|destroy)$ ]]; then
    error "Action inválida. Usar: plan, apply, o destroy"
fi

log "🚀 Iniciando deployment de Cloud Office"
log "Environment: $ENVIRONMENT"
log "Action: $ACTION"

# Verificar que existe el archivo de variables
TFVARS_FILE="environments/$ENVIRONMENT/terraform.tfvars"
if [ ! -f "$TFVARS_FILE" ]; then
    error "Archivo de variables no encontrado: $TFVARS_FILE"
fi

# Verificar Terraform
if ! command -v terraform &> /dev/null; then
    error "Terraform no está instalado"
fi

# Verificar AWS CLI
if ! command -v aws &> /dev/null; then
    error "AWS CLI no está instalado"
fi

# Verificar credenciales AWS
if ! aws sts get-caller-identity &> /dev/null; then
    error "Credenciales AWS no configuradas"
fi

success "✅ Verificaciones completadas"

# Inicializar Terraform
log "📦 Inicializando Terraform..."
terraform init

if [ $? -ne 0 ]; then
    error "Error al inicializar Terraform"
fi

# Seleccionar workspace
log "🔧 Configurando workspace: $ENVIRONMENT"
terraform workspace select $ENVIRONMENT 2>/dev/null || terraform workspace new $ENVIRONMENT

# Ejecutar acción
case $ACTION in
    plan)
        log "📋 Ejecutando Terraform Plan..."
        terraform plan -var-file="$TFVARS_FILE" -out="$ENVIRONMENT.tfplan"
        success "✅ Plan completado. Revisar el output arriba."
        log "Para aplicar los cambios, ejecutar: $0 $ENVIRONMENT apply"
        ;;
    apply)
        log "🚀 Ejecutando Terraform Apply..."
        if [ -f "$ENVIRONMENT.tfplan" ]; then
            terraform apply "$ENVIRONMENT.tfplan"
        else
            warning "No se encontró plan previo. Ejecutando apply directo..."
            terraform apply -var-file="$TFVARS_FILE" -auto-approve
        fi
        
        if [ $? -eq 0 ]; then
            success "✅ Deployment completado exitosamente!"
            log "📊 Obteniendo outputs..."
            terraform output
            
            # Obtener URL del sitio
            WEBSITE_URL=$(terraform output -raw website_url 2>/dev/null)
            if [ ! -z "$WEBSITE_URL" ]; then
                success "🌐 Sitio web disponible en: $WEBSITE_URL"
            fi
        else
            error "Error durante el deployment"
        fi
        ;;
    destroy)
        warning "⚠️  ATENCIÓN: Esto eliminará TODOS los recursos de $ENVIRONMENT"
        read -p "¿Estás seguro? Escribe 'yes' para confirmar: " confirm
        if [ "$confirm" = "yes" ]; then
            log "💥 Ejecutando Terraform Destroy..."
            terraform destroy -var-file="$TFVARS_FILE" -auto-approve
            success "✅ Recursos eliminados"
        else
            log "Operación cancelada"
        fi
        ;;
esac

log "🎉 Proceso completado"
