resource "aws_lb_listener" "front_end" {
  alpn_policy       = null
  certificate_arn   = null
  load_balancer_arn = aws_lb.bar.arn
  port              = 80
  protocol          = "HTTP"
  ssl_policy        = null
  tags              = {}
  tags_all          = {}
  default_action {
    target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:258116398289:targetgroup/twotg/4c16d355a8fdfb3d"
    type             = "forward"
  }
}

# __generated__ by Terraform
resource "aws_lb_target_group" "api" {
  connection_termination             = false
  deregistration_delay               = "300"
  ip_address_type                    = "ipv4"
  port                               = 30632
  preserve_client_ip                 = "true"
  protocol                           = "TCP"
  proxy_protocol_v2                  = false
  slow_start                         = null
  tags = {
    "kubernetes.io/cluster/demo" = "owned"
    "kubernetes.io/service-name" = "default/nginx"
  }
  tags_all = {
    "kubernetes.io/cluster/demo" = "owned"
    "kubernetes.io/service-name" = "default/nginx"
  }
  target_type = "instance"
  vpc_id      = "vpc-099a4d12abb5b36a2"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = null
    path                = null
    port                = "traffic-port"
    protocol            = "TCP"
    timeout             = 10
    unhealthy_threshold = 3
  }
  target_health_state {
    enable_unhealthy_connection_termination = true
  }
}

# __generated__ by Terraform
resource "aws_lb" "bar" {
  desync_mitigation_mode                                       = "defensive"
  idle_timeout                                                 = 60
  ip_address_type                                              = "ipv4"
  load_balancer_type                                           = "application"
  name                                                         = "twoalb"
  preserve_host_header                                         = false
  security_groups                                              = ["sg-0b0fb6e34ec404583"]
  subnets                                                      = ["subnet-02e70dc91aa471a78", "subnet-09d9d24ab2d669cb1"]
  tags                                                         = {}
  tags_all                                                     = {}
  xff_header_processing_mode                                   = "append"
  access_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  connection_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
}
