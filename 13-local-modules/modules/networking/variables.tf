# variable "vpc_cidr" {
#   type        = string
#   description = "Your VPC cidr block"

#   validation {
#     condition     = can(cidrnetmask(var.vpc_cidr))
#     error_message = "The variable vpc_cidr must contain a valid CIDR block value."
#   }

# }

# variable "vpc_name" {
#   type = string
# }

variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block configuration must contain a valid CIDR block value."
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The subnets cidr_block configuration must contain a valid CIDR block value."
  }
}
