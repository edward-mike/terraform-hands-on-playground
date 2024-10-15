resource "aws_s3_bucket" "this" {
  bucket = "tf-cloud-bucket-${random_id.this.hex}"
}

