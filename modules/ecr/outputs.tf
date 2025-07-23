output "repository_url"{
    description = "ECR Repository URL for Docker Push"
    value = aws_ecr_repository.this.repository_url
}
