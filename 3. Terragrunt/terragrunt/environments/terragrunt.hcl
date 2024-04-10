
inputs = {
  # Global
  aws_region ="ap-northeast-1"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "sre-terragrunt-demo"
    key            = "terragrunt/demo/${path_relative_to_include()}/terraform.tfstate"
    region         =  "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}
