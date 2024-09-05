# configuration for ec2 instance
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

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu_ami_data.id
}



# resource "aws_instance" "web" {
#   #   ami                         = "ami-0001da16c715d3db0"
#   ami                         = "ami-0f898b18b2d7f60ec" # nginx ami
#   associate_public_ip_address = true
#   instance_type               = "t2.micro"
#   # associate security group to ec2 instance
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 10
#     volume_type           = "gp3"
#   }
# }
