resource "aws_instance" "api" {
  ami = "ami-0eba6c58b7918d3a1" # <https://cloud-images.ubuntu.com/locator/ec2/>
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_a.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  vpc_security_group_ids = [
    aws_security_group.default.id
  ]
  root_block_device {
    delete_on_termination = true
    # iops                  = 150 # only valid for volume_type io1
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name = "go-api-mysql"
    OS   = "ubuntu"
  }

  depends_on = [aws_security_group.default, aws_key_pair.ec2_key_pair]

  user_data = base64encode(templatefile("user_data.sh", {
    DB_USER = aws_db_instance.mysql_8.username
    DB_PASSWORD = aws_db_instance.mysql_8.password
    DB_HOST = aws_db_instance.mysql_8.address
    DB_PORT = aws_security_group_rule.allow_mysql_in.from_port
    DB_NAME = aws_db_instance.mysql_8.db_name
  }))
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2_key_pair"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generates a local file 
# <https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file> 
resource "local_sensitive_file" "tf_key" {
  content              = tls_private_key.rsa.private_key_pem
  file_permission      = "600"
  directory_permission = "700"
  filename             = "${aws_key_pair.ec2_key_pair.key_name}.pem"
}

# Create an IAM instance profile for the EC2 instance
resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.instance_role.name
}

# Create an IAM role for the EC2 instance
resource "aws_iam_role" "instance_role" {
  name = "ec2-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary IAM policy to the instance role
resource "aws_iam_role_policy_attachment" "instance_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}