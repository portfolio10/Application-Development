variable "ami_id" {
  description = "AMI ID for SCA EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.large"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "shared_key_name" {
  description = "Shared key pair name"
  type        = string
}
