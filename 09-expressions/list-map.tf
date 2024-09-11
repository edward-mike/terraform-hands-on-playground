locals {
    users_map = { for user in var.users_list : user.username => user.role }
}


output "user_role_list" {
  value = local.users_map
}
