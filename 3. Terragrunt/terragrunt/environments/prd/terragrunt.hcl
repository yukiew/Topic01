include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo"
}

inputs = {
  vpc_cidr_block = "172.16.0.0/16"
  subnet_cidr_block = "172.16.1.0/24"
  instance_type = "t2.micro"
}