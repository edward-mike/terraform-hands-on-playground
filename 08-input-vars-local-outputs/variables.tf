# variable "aws_region" {
#   description = "AWS region for the project"
#   type = string
# #   default = "us-east-1"
# }


variable "ec2_instance_type" {
  type        = string
  description = "The type of the instance. either t2.micro or t3.micro"

  #   Adding validation for the instance type
  validation {
    condition     = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    error_message = "Only supports t2.micro and t3.micro"
  }

}

# variable "ec2_volume_size" {
#   type        = number
#   description = "The instance volume size in GB. start from 10"
# }

# variable "ec2_volume_type" {
#   type        = string
#   description = "The instance volume type between gp2 and gp3."

#   # Adding validation for the volumne type
#   validation {
#     condition     = contains(["gp2", "gp3"], var.ec2_volume_type)
#     error_message = "Only supports gp2 and gp3"
#   }
# }


# using object to configure the instance
variable "ec2_instance_configuration" {
  # `object` allow key/value pairs
  type = object({
    size = number
    type = string
  })
  description = "The size and type of the instance root block"

  default = {
    size = 10
    type = "gp2"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}
