locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu_ami_data.id
  }
}



data "aws_ami" "ubuntu_ami_data" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Owner is Canonical
}


resource "aws_instance" "ec2_count" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ubuntu_ami_data.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id # remember the subnet computed from networking.tf is a list, index : 0, 1

  # we want to deploy 4 ec2 instance in the 2 subnets.
  # 0 % 2 = 0
  # 1 % 2 = 1
  # 2 % 2 = 0
  # 3 % 2 = 1

  # 4 ec2 instance distributed across 2 subnets each. ie. each subnet has 2 ec2 instances.

  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}




resource "aws_instance" "ec2_from_config_list" {
  count         = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[ var.ec2_instance_config_list[ count.index ].ami ]
  instance_type = var.ec2_instance_config_list[ count.index ].instance_type 
  subnet_id     = aws_subnet.main[0].id

  tags = {
    Name    = "${local.project}-0"
    Project = local.project
  }
}

