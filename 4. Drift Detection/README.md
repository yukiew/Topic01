# 如何自動偵測 Configuration Drift 

## What is Drift

Drift 是指基礎設施的實際狀態與 IaC 配置中定義的的狀態不同

發生的原因有很多。在配置新增或刪除資源或變更資源定義時，會發生這種情況。

當資源終止或發生故障，以及手動或透過其他自動化工具進行變更時，就會發生Drift的狀態。

## Drift detection tool

### Terraform command

```bash
terraform plan #偵測配置與線上環境差異，顯示為了與配置文件相符會進行的改動
terraform plan  -refresh-only #官方建議使用 可以觀察到線上環境更動的部分
```

```bash
$terraform plan #偵測配置與線上環境差異，顯示為了與配置文件相符會進行的改動

...
Terraform will perform the following actions:

  # aws_security_group.sg will be updated in-place
  ~ resource "aws_security_group" "sg" {
        id                     = "sg-09cc54ab42fa58fe4"
      ~ ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "http"
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
            # (1 unchanged element hidden)
        ]
        name                   = "terraform-20240407080800835500000001"
        tags                   = {
            "Name" = "drift-demo"
        }
        # (8 unchanged attributes hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.
```

```bash
$terraform plan  -refresh-only #官方建議使用 可以觀察到線上環境更動的部分

...
Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which
may have affected this plan:

  # aws_security_group.sg has changed
  ~ resource "aws_security_group" "sg" {
        id                     = "sg-09cc54ab42fa58fe4"
      ~ ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "http"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
            # (1 unchanged element hidden)
        ]
        name                   = "terraform-20240407080800835500000001"
        tags                   = {
            "Name" = "drift-demo"
        }
        # (8 unchanged attributes hidden)
    }

```

### Other tools

基本上 Drift detection 都是付費版才有的功能

- Terraform cloud
- brainBoard
- [More](https://blog.brainboard.co/terraform-drift-detection-how-to-monitor-and-remediate-cloud-infrastructure-drift-3e365921420)

### Demo

```bash
#!/bin/bash

# 設定 Discord webhook URL
WEBHOOK_URL="DISCORD_WEBHOOK"

# 設定 AWS 環境變數
AWS_ACCESS_KEY_ID="MY_AWS_ACCESS_KEY_ID"
WS_SECRET_ACCESS_KEY="MY_AWS_SECRET_ACCESS_KEY"
AWS_DEFAULT_REGION="REGION"

# Terraform 目錄
cd /path/to/terraform

# 執行 Terraform plan，並輸出檔案
terraform plan -refresh-only -out=tfplan > plan_output.txt

# 检查 Terraform plan 是否有 drift 狀態
if grep -q "No changes" plan_output.txt; then
    color=40507
    message="Everything OK"
    title="No Drift"
    req_data="{\"username\": \"Drift Detected\", \"embeds\": [{\"title\": \"$title\",\"description\": \"$message\",\"color\": $color}]}"

else
    # drift, discord 發送通知
    # 設定 call data 需要帶入的資訊
    color=16711680
    message="Detected Drift in demo project!"
    title="Drift detected"
    fields="[{\"name\": \"Terraform script:\",\"value\": \"terraform plan -refresh-only\"}]"
    req_data="{\"username\": \"Drift Detected\", \"embeds\": [{\"title\": \"$title\",\"description\": \"$message\",\"color\": $color,\"fields\": $fields}]}"
fi

# Call api
curl \
  -H "Content-Type: application/json" \
  -X POST \
  -d "$req_data" "$WEBHOOK_URL"

```

寫好 script 後設定 cronjob 即可實作Auto drift detection

### Reference

[Terraform Manage resource drift](https://developer.hashicorp.com/terraform/tutorials/state/resource-drift)
[Terraform cloud drift detection](https://www.hashicorp.com/campaign/drift-detection-for-terraform-cloud)
