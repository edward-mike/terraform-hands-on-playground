ec2_instance_type = "t3.micro"

ec2_instance_configuration = {
  size = 10
  type = "gp2"
}
additional_tags = {
  ValuesFrom = "terraform.tfvar"
}
