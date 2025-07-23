output "dast_s3_bucket_name" {
  value = aws_s3_bucket.dast_s3_bucket.id
}

output "dast_s3_bucket_arn" {
  value = aws_s3_bucket.dast_s3_bucket.arn
}

output "sast_s3_bucket_name" {
  value = aws_s3_bucket.sast_s3_bucket.id
}

output "sast_s3_bucket_arn" {
  value = aws_s3_bucket.sast_s3_bucket.arn
}
