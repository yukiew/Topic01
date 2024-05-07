variable "task" {
  default = "top01-2"
  type    = string
}

variable "aws_region" {
  default = "ap-northeast-1"
  type    = string
}

variable "main_vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "private_subnet_range_a" {
  default = "10.0.1.0/24"
  type    = string
}

variable "private_subnet_range_b" {
  default = "10.0.2.0/24"
  type    = string
}

variable "public_subnet_range_a" {
  default = "10.0.0.0/24"
  type    = string
}