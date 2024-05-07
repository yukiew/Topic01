// Provider configuration
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.0"
   }
 }
}
 
provider "aws" {
 region = "ap-northeast-1"
}

import {
 id = "i-080dc376545d6ab4a"
 
 to = aws_instance.this
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "your-bucket-name" # 這裡使用你的bucket名稱
  acl    = "private"
}

import {
  to = aws_s3_bucket.bucket
  id = "bucket-name"
}