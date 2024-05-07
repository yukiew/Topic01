# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "i-080dc376545d6ab4a"
resource "aws_instance" "this" {
  ami                                  = "ami-0eba6c58b7918d3a1"
  associate_public_ip_address          = false
  availability_zone                    = "ap-northeast-1c"
  cpu_core_count                       = 1
  cpu_threads_per_core                 = 1
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  iam_instance_profile                 = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "1234"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = null
  private_ip                           = "172.31.2.128"
  secondary_private_ips                = []
  security_groups                      = ["launch-wizard-10"]
  source_dest_check                    = true
  subnet_id                            = "subnet-08f18d3218b5eaf44"
  tags = {
    Name = "test123"
  }
  tags_all = {
    Name = "test123"
  }
  tenancy                = "default"
  user_data              = null
  user_data_base64       = null
  volume_tags            = null
  vpc_security_group_ids = ["sg-00f1ea0a60d67044e"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 8
    volume_type           = "gp2"
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}
