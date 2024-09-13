# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance

#########################################
# EC2                                   #
#########################################

locals {
  instance_type = "t2.micro"
}

data "aws_ami" "ubuntu_ami" {

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


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name                   = local.project_name
  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = local.instance_type
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = local.common_tags
}
