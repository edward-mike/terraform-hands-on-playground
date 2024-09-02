terraform {
  # Required version of terraform 
  required_version = ">= 1.7.0"

  # specify providers to use  
  required_providers {
    # cloud provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # allowed versions 5.x and later, but not 6.x
    }

    # useful for random value generation
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # allowed versions 3.x and later, but not 4.x
    }
  }

  # tf state backend configuration with s3
  backend "s3" {
    
  }

}


provider "aws" {
  region = "us-east-1" # infrastructure region
}
