data "aws_ami" "ubuntu_ami_data" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Owner is Canonical
}

# ec2 instance
resource "aws_instance" "ec2" {
  ami = data.aws_ami.ubuntu_ami_data.id

  instance_type = var.ec2_instance_configuration.type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_instance_configuration.size
    volume_type           = var.ec2_instance_configuration.type
  }

  tags = merge(var.additional_tags, {
    ManagedBy = "Terraform"
  })

}
