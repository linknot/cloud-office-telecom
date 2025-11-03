################################################################################################
# ＴＥＲＲＡＦＯＲＭ ＆ ＲＥＱＵＩＲＥＤ ＰＲＯＶＩＤＥＲＳ ＶＥＲＳＩＯＮＳ ＣＯＮＦＩＧＵＲＡＴＩＯＮ #
################################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

##################################################
# ＡＷＳ ＰＲＯＶＩＤＥＲ ＣＯＮＦＩＧＵＲＡＴＩＯＮ #
##################################################

# 'projectAWSAssumeRoleReplace' -> 𝙎𝙚 𝙧𝙚𝙚𝙢𝙥𝙡𝙖𝙯𝙖𝙧𝙖 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙢𝙚𝙣𝙩𝙚 𝙘𝙤𝙣 𝙚𝙡 𝙧𝙤𝙡 𝙙𝙚 𝙨𝙚𝙧𝙫𝙞𝙘𝙞𝙤 𝙙𝙚 𝙡𝙖 𝙖𝙥𝙡𝙞𝙘𝙖𝙘𝙞𝙤𝙣

provider "aws" {
  region = var.aws_region
  
  # Descomentar para usar assume role
  # assume_role {
  #   role_arn = "arn:aws:iam::${local.account_id[terraform.workspace]}:role/projectAWSAssumeRoleReplace"
  # }

  default_tags {
    tags = var.tags
  }
}

# 𝘼𝙒𝙎 𝘼𝘾𝘾𝙊𝙐𝙉𝙏𝙎 𝙄𝘿❜𝙨
# 'projectMasterAccountIDReplace' -> 𝙎𝙚 𝙧𝙚𝙚𝙢𝙥𝙡𝙖𝙯𝙖𝙧𝙖 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙢𝙚𝙣𝙩𝙚 𝙘𝙤𝙣 𝙚𝙡 𝘼𝙒𝙎 𝘼𝙘𝙘𝙤𝙪𝙣𝙩𝙄𝘿 𝙙𝙚 𝙋𝙧𝙤𝙙𝙪𝙘𝙘𝙞𝙤𝙣
# 'projectTestingAccountIDReplace' -> 𝙎𝙚 𝙧𝙚𝙚𝙢𝙥𝙡𝙖𝙯𝙖𝙧𝙖 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙢𝙚𝙣𝙩𝙚 𝙘𝙤𝙣 𝙚𝙡 𝘼𝙒𝙎 𝘼𝙘𝙘𝙤𝙪𝙣𝙩𝙄𝘿 𝙙𝙚 𝙏𝙚𝙨𝙩𝙞𝙣𝙜
# 'projectDevelopAccountIDReplace' -> 𝙎𝙚 𝙧𝙚𝙚𝙢𝙥𝙡𝙖𝙯𝙖𝙧𝙖 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙢𝙚𝙣𝙩𝙚 𝙘𝙤𝙣 𝙚𝙡 𝘼𝙒𝙎 𝘼𝙘𝙘𝙤𝙪𝙣𝙩𝙄𝘿 𝙙𝙚 𝘿𝙚𝙫𝙚𝙡𝙤𝙥

locals {
  account_id = {
    master  = "118349890720"  # Cuenta actual de Cloud Office
    testing = "projectTestingAccountIDReplace"
    develop = "projectDevelopAccountIDReplace"
  }
}

######################################################################
# ＩＭＰＯＲＴ ＲＥＭＯＴＥ ＳＴＡＴＥ ＦＩＬＥ ＣＯＮＦＩＧＵＲＡＴＩＯＮ #
######################################################################

# 𝙀𝙣 𝙘𝙖𝙨𝙤 𝙙𝙚 𝙦𝙪𝙚𝙧𝙚𝙧 𝙞𝙢𝙥𝙤𝙧𝙩𝙖𝙧 𝙪𝙣 𝙨𝙩𝙖𝙩𝙚 𝙛𝙞𝙡𝙚 𝙧𝙚𝙢𝙤𝙩𝙤, 𝙨𝙚𝙜𝙪𝙞𝙧 𝙡𝙖𝙨 𝙨𝙞𝙜𝙪𝙞𝙚𝙣𝙩𝙚𝙨 𝙞𝙣𝙨𝙩𝙧𝙪𝙘𝙘𝙞𝙤𝙣𝙚𝙨:
# １ - 𝘿𝙚𝙨𝙘𝙤𝙢𝙚𝙣𝙩𝙖𝙧 𝙚𝙡 𝙨𝙞𝙜𝙪𝙞𝙚𝙣𝙩𝙚 𝙗𝙡𝙤𝙦𝙪𝙚 𝙙𝙚 𝙘𝙤𝙙𝙞𝙜𝙤
# ２ - 𝙍𝙚𝙚𝙢𝙥𝙡𝙖𝙯𝙖𝙧 𝙘𝙤𝙣 𝙚𝙡 𝙣𝙤𝙢𝙗𝙧𝙚 𝙙𝙚 𝙩𝙪 𝙥𝙧𝙤𝙮𝙚𝙘𝙩𝙤．
# ３ - 'projectWorkSpaceReplace' -> 𝘾𝙖𝙢𝙗𝙞𝙖𝙧𝙖́ 𝙙𝙚 𝙫𝙖𝙡𝙤𝙧 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙢𝙚𝙣𝙩𝙚 𝙚 𝙞𝙢𝙥𝙤𝙧𝙩𝙖𝙧𝙖́ 𝙚𝙡 𝙨𝙩𝙖𝙩𝙚 𝙛𝙞𝙡𝙚 𝙙𝙚𝙡 𝙒𝙤𝙧𝙠𝙎𝙥𝙖𝙘𝙚 𝙘𝙤𝙧𝙧𝙚𝙘𝙩𝙤.

# data "terraform_remote_state" "iac_state" {
#   backend = "s3"
#   config = {
#     bucket         = "projectBuckendBucketReplace"
#     key            = "Terraform/IaC/projectWorkSpaceReplace/cloud-office-telecom.tfstate"
#     region         = "projectAWSRegionReplace"
#     dynamodb_table = "projectDynamoDBReplace"
#   }
# }

# Variable para región AWS
variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}
