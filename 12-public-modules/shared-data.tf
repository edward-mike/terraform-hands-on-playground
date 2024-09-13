locals {
  region       = "us-east-1"
  project_name = "12-public-modules"

  common_tags = {
    Project   = local.project_name
    ManagedBy = "Terraform"
  }
}
