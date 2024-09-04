############################
# Networking configuration #
############################

locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "06-resources"
  }
}


# Configuration for VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "06-resources"
  })

}

# Configure subnets
resource "aws_subnet" "public" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.common_tags, {
    Name = "06-resources-public"
  })
}

# config. internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.common_tags
}

# config. route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id # associate with IGW
  }

  tags = merge(local.common_tags, {
    Name = "06-resources-rt-public"
  })

}

# config. association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
