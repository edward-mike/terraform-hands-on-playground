variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lastname = string
  }))
}

variable "numbers_map" {
  type = map(number)
}


variable "users_list" {
  type = list(object({
    username = string
    role = string
  }))
}
