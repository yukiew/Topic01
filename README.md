# Topic-1-Terraform

1. 把非 terraform 建立的 AWS 資源讓 terraform 管理 (ex. EKS / Workgroup / RDS / Redis / ALB / Cloudfront / Route53 / S3)
2. 把一個 terraform state file 拆成四個 state file，並且互相使用對方的資源。<br/>
   (state file 1: Route53, state file 3: S3 , state file 3: RDS / Redis, state file 4: EKS / Workgroup / ALB / Cloudfront )
4. 使用 terragrunt 來降低 terraform HCL 的重覆性
5. 如何自動偵測 Configuration Drift (線上環境設定和 repository 不一樣)
