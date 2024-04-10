# 使用 Terragrunt 來降低 terraform HCL 的重覆性

## Terraform

Terraform 架構

```bash
├── environments
│   ├── dev
│   │   └── main.tf
│   └── prod
│       └── main.tf
└── modules
    └── demo
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

當modules變得愈來愈複雜，各個environment中重複的程式碼也會隨之增加

Terraform只是配置文件的管理工具，沒有函數複用的功能，為了解決此問題而有了terragrunt

## Terragrunt

Terragrunt 是 gruntwork 推出的一個 Terraform thin wrapper

terragrunt 架構

```bash
├── environments
│   ├── dev
│   │   └── terragrunt.hcl
│   ├── prod
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
└── modules
    └── demo
        ├── main.tf
        └── variables.tf
```

  為了提高Terraform的可重用性，Terragrunt的做法就是將模組和配置分開:

- 使用Terrafrom 定義通用模版或模組,存放在遠端倉庫中
- 使用Terragrunt管理特定參數配置
- Terragrunt程式碼引用Terraform模組並使用terragrunt apply 產生最終的配置

**The Root Terragrunt Configuration File** (./environments/terrgrunt.hcl)
定義重複項目

```bash
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
```

**The Terragrunt Configuration File in dev folder** (./environments/dev/terrgrunt.hcl)

```bash
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo"
}

inputs = {
  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
  instance_type = "t2.micro"
}
```

### Terragrunt commands

```jsx
terragrunt init
terragrunt plan
terragrunt apply
terragrunt destroy

# 可以刪除所有環境中的資源
terragrunt run-all destroy
```

### Terragrunt cache

Terragrunt cache是Terragrunt在當前目錄中創建的資料夾，用於存儲下載的Terraform module, backend…。Terragrunt使用此cache來避免多次下載相同的程式碼，以加快執行速度

### Terragrunt Benefits and Drawbacks

 benefits:

- 有效率地管理 remote state 設定
- 保持良好的開發原則 DRY

drawbacks:

- 需要實作可重複使用的 Terraform module 增加了開發與維護的時間成本

### Reference
[Terragrunt Tutorial: Examples and Use Cases](https://www.env0.com/blog/terragrunt)
[Terragrunt官網](https://terragrunt.gruntwork.io/docs/#getting-started) 