ec2_instance_type = "t2.micro"

ec2_instance_configuration = {
  size = 10
  type = "gp3"
}
additional_tags = {
  ValuesFrom = "dev.terraform.tfvar"
}
