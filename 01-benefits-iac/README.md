# Creating VPCs and Subnets with Terraform and IaC

## Introduction

This repository contains Terraform configuration files for setting up a basic infrastructure on AWS. In this example, we'll create a Virtual Private Cloud (VPC) with two subnets—one public and one private. Additionally, we'll set up an Internet Gateway and a Route Table, which will be associated with the public subnet. This setup reflects a typical cloud infrastructure configuration, enhancing security and control by segregating resources into public and private subnets.

## Desired Outcome

By the end of this setup, the Terraform configuration will deploy the following:

- **A VPC** with a CIDR block of `10.0.0.0/16`.
- **One public subnet** with a CIDR block of `10.0.0.0/24`.
- **One private subnet** with a CIDR block of `10.0.1.0/24`.
- **One Internet Gateway**.
- **One public route table** with a route to the Internet Gateway, and the association between the public subnet and the public route table.

## Useful Resources

- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws)

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed on your machine.
- AWS account credentials configured. For more details, see [Configuring Credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication).

### Step-by-Step Guide

1. Initialize Terraform Configuration

   Create a file named `main.tf` and add the following configuration to set up the required providers:
```
   terraform {
     required_providers {
       aws = {
         source  = "hashicorp/aws"
         version = "~> 5.0"
       }
     }
   }
```

2. Configure the AWS Provider
Add the AWS provider block to `main.tf` to specify the region where resources will be created:

```
provider "aws" {
  region = "eu-west-2"
}
```

3. Create the VPC
Define a VPC resource in `main.tf`:
```
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform VPC"
  }
}

```

4. Create Subnets
Add the following resources to define the public and private subnets:
```
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}

```

5. Create an Internet Gateway
Add the Internet Gateway resource to `main.tf`:
```
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
}
```

6. Create a Route Table

Define the route table and its route to the Internet Gateway:
```
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
```

7. Associate the Route Table with the Public Subnet
Complete the setup by associating the route table with the public subnet
```
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
```

**Applying the Configuration**
Run the following commands to apply your Terraform configuration:
```
terraform init
terraform plan
terraform apply
terraform destroy
```
