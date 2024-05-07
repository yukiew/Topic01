// Provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

# import {
#   to = aws_db_instance.instance
#   id = "database-1"
# }

# import {
#   to = aws_security_group.sg
#   id = "sg-0d7a6e04421e62d9b"
# }

data "terraform_remote_state" "route53_state" {
  backend = "local"
  config = {
    path = "../route53/terraform.tfstate"
  }
}
