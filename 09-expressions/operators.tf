locals {
  maths      = 2 * 3 # operators: *, /, %, -, -<number>
  equality   = 2 != 4
  comparison = 2 < 9
  logical    = true && false

}


output "operators" {
  value = {
    maths  = local.maths
    equal  = local.equality
    compar = local.comparison
    logic  = local.logical

  }
}
