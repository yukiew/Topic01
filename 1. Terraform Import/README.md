# Terraform Import

## lab 01

步驟1: 創建AWS S3 Bucket
登入到AWS console，創建一個新的s3 bucket，記下你的bucket名稱，我們稍後會用到。

​​步驟2: 準備Terraform配置文件
在你的Terraform專案資料夾中，文件main.tf。
main.tf:
```tf
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

resource "aws_s3_bucket" "mybucket" {
 bucket = "your-bucket-name"
 acl    = "private"
}
```

步驟3: 初始化Terraform
```bash
terraform init
```

步驟4: 導入現有資源到Terraform
使用terraform import命令將你創建的S3 bucket導入到Terraform的狀態中。你需要提供資源類型和實際資源ID。對於S3 bucket，命令將如下：
```
terraform import aws_s3_bucket.mybucket <剛剛創建的bucket name>
```
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket


步驟6: 應用配置
執行terraform plan來檢視變更，使用terraform apply來應用配置。由於資源已經存在，Terraform應該不會進行任何變更。

## lab 02

步驟1: 創建AWS S3 Bucket
登入到AWS console，創建一個新的s3 bucket，記下你的bucket名稱，我們稍後會用到。

​​步驟2: 準備Terraform配置文件
在你的Terraform專案資料夾中，文件main.tf。
main.tf:
```tf
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
 to = aws_s3_bucket.mybucket
 id = "bucket-name"
}
```

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

步驟3: 初始化Terraform
```bash
terraform init
```

步驟4: 導入現有資源到Terraform，並自動生成tf檔。
使用terraform 透過block 將你創建的S3 bucket導入到Terraform的狀態中。與import指令不同的是，你需要將對應的id填進import block，而不是指令中。並且用下列命令可以生成tf檔：
```bash
terraform plan -generate-config-out=generated_resources.tf
```
https://spacelift.io/blog/importing-exisiting-infrastructure-into-terraform


步驟6: 查看應用配置
打開 generated_resources.tf 就可查看自動生成的內容了，但自動生成功能目前算是個實驗性值的功能。
