# ami 이미지 설정
variable "jenkins_ami_id" {
  description = "ami-043ce2e5b2d8eb73a"
  type        = string
}

variable "sast_ami_id"{
  description = "AMI ID for SAST"
  type = string
}

variable "sca_ami_id"{
  description = "AMI ID for SCA"
  type = string
}

variable "dast_ami_id"{
  description = "AMI ID for DAST"
  type = string
}

variable "jenkins_iam_instance_profile" {
  type = string
}

# 네트워크
variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

# 지역
variable "region" {
  description = "AWS region"
  type        = string
}

# ecr 저장소
variable "ecr_repository_name"{
  description = "ECR에 생성할 리포지토리 이름"
  type = string
}

# 🔸 SAST 관련 변수
variable "sast_slack_webhook_url" {
  type = string
}

variable "sast_s3_bucket_name" {
  type = string
}

variable "sast_s3_filter_prefix" {
  type = string
}

variable "sast_s3_bucket_arn" {
  type = string
}

# 🔸 DAST 관련 변수
variable "dast_slack_webhook_url" {
  type = string
}

variable "dast_s3_bucket_name" {
  type = string
}

variable "dast_s3_filter_prefix" {
  type = string
}

variable "dast_s3_bucket_arn" {
  type = string
}

# alb 관련 변수

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "alb_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "cloudfence-alb"
}

#codedeploy 설정
variable "project_name" {
  description = "The mane of the overall project, used for naming resources"
  type = string
}