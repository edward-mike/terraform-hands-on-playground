locals {
  users_from_yml = yamldecode(file("${path.module}/user-roles.yml")).users
}


# create a users resource
resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yml[*].username)
  name     = each.value
}

# create a users login profile
resource "aws_iam_user_login_profile" "users_login" {
  for_each        = aws_iam_user.users
  user            = each.value.name # retrieve name from users list
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,         # Dev. test purpose only
      password_reset_required, # Dev. test purpose only
      pgp_key                  # Dev. test purpose only
    ]
  }
}

# output "users" {
#   value = local.users_from_yml
# }

# NOTE: don't do this in real applications
output "passwords" {
  value = { for user, user_login in aws_iam_user_login_profile.users_login : user => user_login.password }
}
