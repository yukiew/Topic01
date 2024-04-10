variable "aws_region" {
  description = "AWS Region"
  type        = string
}

# Resource AWS VPC
variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

# Resource AWS Subnet
variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  type        = string
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
