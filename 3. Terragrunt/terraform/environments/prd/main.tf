terraform {
  backend "s3" {
    bucket         = "demo"
    key            = "demo/prd/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

module "demo" {
  source            = "../../modules/demo"
  aws_region        = "ap-northeast-1"
  vpc_cidr_block    = "10.1.0.0/16"
  subnet_cidr_block = "10.1.1.0/24"
  instance_type     = "t2.small" //type of instance
}
