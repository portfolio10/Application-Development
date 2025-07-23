variable "function_name" {
  type        = string
  description = "SAST용 Lambda 이름"
}

variable "iam_role_arn" {
  type        = string
  description = "IAM 역할 ARN"
}

variable "slack_webhook_url" {
  type        = string
  description = "Slack Webhook URL"
}

variable "sast_s3_bucket_name" {
  type        = string
  description = "S3 버킷 이름"
}

variable "sast_s3_filter_prefix" {
  type        = string
  description = "S3 키 접두어"
}

variable "sast_s3_bucket_arn" {
  type        = string
  description = "S3 버킷 ARN"
}
