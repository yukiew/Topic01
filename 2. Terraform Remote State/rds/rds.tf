# RDS Subnet Group
resource "aws_db_subnet_group" "private_db_subnet" {
  name        = "mysql-rds-private-subnet-group"
  description = "Private subnets for RDS instance"
  # Subnet IDs must be in two different AZ. Define them explicitly in each subnet with the availability_zone property
  subnet_ids = ["${aws_subnet.private_subnet_a.id}", "${aws_subnet.private_subnet_b.id}"]
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow inbound/outbound MySQL traffic"
  vpc_id      = aws_vpc.main.id
  depends_on  = [aws_vpc.main]
}

# Allow inbound MySQL connections
resource "aws_security_group_rule" "allow_mysql_in" {
  description              = "Allow inbound MySQL connections"
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.default.id
  security_group_id        = aws_security_group.rds_sg.id
}

# RDS Instance
resource "aws_db_instance" "mysql_8" {
  allocated_storage = 10         # Storage for instance in gigabytes
  identifier = "codeherk-tf-db"  # The name of the RDS instance
  storage_type = "gp2"           # See storage comparision <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#storage-comparison>
  engine = "mysql"               # Specific Relational Database Software <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html#Welcome.Concepts.DBInstance>
  
  # InvalidParameterCombination: RDS does not support creating a DB instance with the following combination: DBInstanceClass=db.t4g.micro, Engine=mysql, EngineVersion=5.7.41,
  # <https://aws.amazon.com/about-aws/whats-new/2021/09/amazon-rds-t4g-mysql-mariadb-postgresql/>
  engine_version = "8.0.32"
  instance_class = "db.t4g.micro" # See instance pricing <https://aws.amazon.com/rds/mysql/pricing/?pg=pr&loc=2>
  multi_az = true

  # mysql -u dbadmin -h <ENDPOINT> -P 3306 -D sample -p
  db_name  = "sample"           # name is deprecated, use db_name instead
  username = "dbadmin"
  password = "12345678"

  db_subnet_group_name = aws_db_subnet_group.private_db_subnet.name  # Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group.
  # Error: final_snapshot_identifier is required when skip_final_snapshot is false
  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]
}
