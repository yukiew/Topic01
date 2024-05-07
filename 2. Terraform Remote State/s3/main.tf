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
#   to = aws_s3_bucket.bucket
#   id = var.bucketName
# }

# import {
#   to = aws_s3_object.index_html
#   id = "two.totaloggy.live/index.html"
# }

# import {
#   to = aws_s3_bucket_website_configuration.web
#   id = aws_s3_bucket.bucket.id
# }

# import {
#   to = aws_s3_bucket_public_access_block.public_access_block
#   id = aws_s3_bucket.bucket.id
# }

# import {
#   to = aws_s3_bucket_policy.bucket_policy
#   id = aws_s3_bucket.bucket.id
# }

data "terraform_remote_state" "route53_state" {
  backend = "local"
  config = {
    path = "../route53/terraform.tfstate"
  }
}
