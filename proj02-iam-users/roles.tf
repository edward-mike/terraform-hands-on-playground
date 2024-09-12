locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ]
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonVPCFullAccess",
      "AmazonEC2FullAccess",
      "AmazonRDSFullAccess"
    ]
  }


  role_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])

}


# output "policies_list" {
#   value = local.role_policies_list
# }


# dummy assume_role_policies
# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = [
#       "sts:AssumeRole"
#     ]
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::058264144724:user/laura"]
#     }
#   }
# }

# # create roles
# resource "aws_iam_role" "roles" {
#   for_each           = toset(keys(local.role_policies)) # get role keys from object
#   name               = each.key
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

# # managed policies
# data "aws_iam_policy" "managed_policies" {
#   for_each = toset(local.role_policies_list[*].policy)
#   arn      = "arn:aws:iam::aws:policy/${each.value}"
# }

# # associate data policies to roles
# resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
#   count = length(local.role_policies_list)

#   role = aws_iam_role.roles[
#   local.role_policies_list[count.index].role].name

#   policy_arn = data.aws_iam_policy.managed_policies[
#   local.role_policies_list[count.index].policies]
# }
