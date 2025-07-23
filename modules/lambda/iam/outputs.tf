output "role_arn" {
  description = "람다에 연결할 IAM 역할의 ARN"
  value       = aws_iam_role.lambda_role.arn
}
