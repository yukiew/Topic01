# Terraform data terraform_remote_state

如何使用 data "terraform_remote_state“

在other terraform outputs.tf
```
output "s3_bucket_arn" {d
  value = aws_s3_bucket.mybucket.arn
}
```

在current terraform main.tf
```
data "terraform_remote_state" "source_state" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state-bucket"
    key    = "path/to/my/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_something" "example" {
  some_attribute = data.terraform_remote_state.source_state.outputs.s3_bucket_arn
}
```

好用的指令

terraform list
用途：列出當前terraform state file 管理的所有資源



terraform state rm
用途：移除管理當前terraform state file 指定的資源
ex: 
```
terraform state rm aws_s3_bucket.mybucket
```
