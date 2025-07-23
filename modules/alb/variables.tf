variable "vpc_id" {
  description = "The VPC ID for the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID to associate with the ALB"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "cloudfence-alb"
}

variable "alb_certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS listener"
  type        = string
}
