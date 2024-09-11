locals {
  firstname_from_splat = var.objects_list[*].firstname
}

output "firstname_from_splat" {
  value = local.firstname_from_splat
}
