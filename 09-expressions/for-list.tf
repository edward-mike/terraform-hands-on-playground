locals {
  double_numbers = [for number_ in var.numbers_list : number_ * 2]
  even_numbers   = [for number_ in var.numbers_list : number_ if number_ % 2 == 0]
}

locals {
  firstnames = [ for person in var.objects_list : person.firstname  ]
}


output "double_numbers" {
  value = local.double_numbers
}


output "even_numbers" {
  value = local.even_numbers
}

################################################################

output "person_firstnames" {
  value = local.firstnames
}
