###########################
# S3 bucket configuration #
###########################

resource "random_id" "s3_bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucket-${random_id.s3_bucket_suffix.hex}"
}

# Lets output bucket name on terminal.
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
