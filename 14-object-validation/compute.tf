# configuration for ec2 instance
locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]
}


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




# configuration for ec2 instance
resource "aws_instance" "this" {
  ami           = "ami-0f898b18b2d7f60ec"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.this.id

  # configure root-block device
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "invalid instance type"
    }
  }

}
