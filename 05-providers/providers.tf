terraform {
  # Required version of terraform 
  required_version = ">= 1.7.0"

  # specify providers to use  
  required_providers {
    # cloud provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # allowed versions 5.x and later, but not 6.x or 4.x
    }
  }

}

# Imagine we want to deploy s3 bucket in two regions.

# region - 1 
provider "aws" {
  region = "us-east-1"
}

# region - 2 
provider "aws" {
  region = "us-west-1"
  alias  = "us-west-region" # alias is required to differentiate regions
}



# Congfig. s3 resources
resource "aws_s3_bucket" "bucket-1" {
  bucket = "us-east-bucket-ashu67" # default to no alias `us-east-1`
}

resource "aws_s3_bucket" "bucket-2" {
  bucket   = "us-west-bucket-dghd8"
  provider = aws.us-west-region # using alias region `us-west-1`
}
