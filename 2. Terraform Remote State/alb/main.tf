// Provider configuration
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

# import {
#   to = aws_lb_target_group.api
#   id = "arn:aws:elasticloadbalancing:ap-northeast-1:258116398289:targetgroup/k8s-default-nginx-a95fc05638/062f27174af622e2"
# }

# import {
#   to = aws_lb.bar
#   id = "arn:aws:elasticloadbalancing:ap-northeast-1:258116398289:loadbalancer/app/twoalb/afc92048e131f038"
# }

# import {
#   to = aws_lb_listener.front_end
#   id = "arn:aws:elasticloadbalancing:ap-northeast-1:258116398289:listener/app/twoalb/afc92048e131f038/c176136d26a9a574"
# }

# import {
#   to = aws_lb_listener_rule.front_end
#   id = "arn:aws:elasticloadbalancing:ap-northeast-1:258116398289:listener-rule/app/twoalb/afc92048e131f038/c176136d26a9a574/28ca9031cadb85e9"
# }

data "terraform_remote_state" "route53_state" {
  backend = "local"
  config = {
    path = "../route53/terraform.tfstate"
  }
}
