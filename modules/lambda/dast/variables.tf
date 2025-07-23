variable "function_name" {
  type        = string
  description = "DAST용 Lambda 함수 이름"
}

variable "iam_role_arn" {
  type        = string
  description = "Lambda에 연결할 IAM 역할 ARN"
}

variable "slack_webhook_url" {
  type        = string
  description = "DAST용 Slack Webhook URL"
}

variable "dast_s3_bucket_name" {
  type        = string
  description = "DAST 결과가 저장될 S3 버킷 이름"
}

variable "dast_s3_filter_prefix" {
  type        = string
  description = "DAST 결과가 저장될 S3 경로 prefix"
}

variable "dast_s3_bucket_arn" {
  type        = string
  description = "DAST 결과 S3의 ARN"
}
