#!/bin/bash

# 設定 Discord webhook URL
WEBHOOK_URL="{Discord_webhook}"

# 設定 AWS 環境變數
AWS_ACCESS_KEY_ID="{My_AWS_Access_Key_ID}"
WS_SECRET_ACCESS_KEY="{My_AWS_Secret_key}"
AWS_DEFAULT_REGION="{AWS_Region}"

# Terraform 目錄
cd /path/to/folder

# 執行 Terraform plan，並輸出檔案
terraform plan -refresh-only -out=tfplan > plan_output.txt

# 检查 Terraform plan 是否有drift 狀態
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
