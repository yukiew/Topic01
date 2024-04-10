include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo"
}

inputs = {
  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
  instance_type = "t2.micro"
}