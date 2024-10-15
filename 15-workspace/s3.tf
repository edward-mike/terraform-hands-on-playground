resource "random_id" "s3_bucket_suffix" {
  byte_length = 6
}


/*
dev => 1
staging => 2
prod => 3

*/

resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "bucket-${terraform.workspace}-${count.index}-${random_id.s3_bucket_suffix.hex}"
}

