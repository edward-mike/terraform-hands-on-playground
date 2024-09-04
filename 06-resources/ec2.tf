# configuration for ec2 instance
resource "aws_instance" "web" {
  #   ami                         = "ami-0001da16c715d3db0"
  ami                         = "ami-0f898b18b2d7f60ec" # nginx ami
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  # associate security group to ec2 instance
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "06-resources-ec2"
  })

# override the default to create a new instance before destroying.
  lifecycle {
    create_before_destroy = true
  }

}


# comfig. security group SG
resource "aws_security_group" "public_http_traffic" {
  description = "security group allowing traffic on port 443 and 80"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "06-resources-sg"
  })
}

# configuration for ingress rule on port 80
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# configuration for ingress rule on port 443
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
