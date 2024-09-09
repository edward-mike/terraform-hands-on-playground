# simple local
locals {
  project = "terraform-project"
  managed_by = "Terraform tool"
  cost_center = "111222233"
}


# Making locals a bit nested
locals {
  config_tags = {
    cost_center = local.cost_center
  }
}
