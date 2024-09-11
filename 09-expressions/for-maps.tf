locals {
  doubles_map = { for k,v in var.numbers_map : k => v if v < 3 }
}

output "numbers_map_" {
  value = local.doubles_map
}


