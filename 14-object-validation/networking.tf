data "aws_vpc" "default_vpc" {
  default = true
}


resource "aws_subnet" "this" {
  vpc_id     = data.aws_vpc.default_vpc.id
  cidr_block = "172.31.128.0/24"

  lifecycle {
    postcondition {
      condition     = self.availability_zone == "us-east-1a"
      error_message = "Invalid availability zone"
    }
  }

}
