variable "ami_id" {
  description = "ami-043ce2e5b2d8eb73a" //jenkins 백업 ami파일.
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for jenkins"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "EC2를 배치할 Subnet ID"
  type = string
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "shared_key_name" {
  description = "Name of the shared EC2 key pair"
  type        = string
}
