variable "ami_id" {
  description = "AMI ID for DAST EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.large"
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "shared_key_name" {
  type = string
}
