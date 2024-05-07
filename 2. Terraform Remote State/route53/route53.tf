resource "aws_route53_record" "record" {
  zone_id = "Z062726611FKDM13M21VV"
  name    = data.terraform_remote_state.s3_state.outputs.bucket_name
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = "s3-website-ap-northeast-1.amazonaws.com"
    zone_id                = "Z2M4EHUR26P7ZW"
  }
}
