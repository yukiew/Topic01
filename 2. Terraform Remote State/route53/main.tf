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

import {
  to = aws_route53_record.record
  id = "Z056919537J1SEVOGYO3B_two.totaloggy.live_A"
}

data "terraform_remote_state" "s3_state" {
  backend = "local"
  config = {
    path = "../s3/terraform.tfstate"
  }
}
