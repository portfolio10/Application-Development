resource "aws_s3_bucket" "dast_s3_bucket" {
  bucket = var.dast_s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket" "sast_s3_bucket" {
  bucket = var.sast_s3_bucket_name
  force_destroy = true
}
