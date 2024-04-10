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

resource "aws_vpc" "vpc" {

  tags = {
    Name = "drift-demo"
  }
  cidr_block = "10.2.0.0/16"
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.1.0/24"
  tags = {
    Name = "drift-demo"
  }
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn2-ami-kernel-5.10-hvm-2.0.20231206.0-x86_64-gp2",
    ]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm",
    ]
  }

  owners = [
    "137112412989",
  ]
}

resource "aws_instance" "instance" {
  subnet_id                   = aws_subnet.main_subnet.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  ami                         = data.aws_ami.ami.id

  vpc_security_group_ids = [
    aws_security_group.sg.id,
  ]
  tags = {
    Name = "drift-demo"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id

  egress {
    to_port   = 0
    protocol  = "-1"
    from_port = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    to_port     = 22
    protocol    = "tcp"
    from_port   = 22
    description = "ssh"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    Name = "drift-demo"
  }
}

