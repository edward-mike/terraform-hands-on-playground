terraform {
  cloud {

    organization = "scriptycloud-org"

    workspaces {
      name = "terraform-cli-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # allowed versions 3.x and later, but not 4.x
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
