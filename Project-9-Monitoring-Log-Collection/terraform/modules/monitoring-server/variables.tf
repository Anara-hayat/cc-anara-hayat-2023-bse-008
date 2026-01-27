variable "subnet_id" {
  description = "Subnet ID where monitoring server will be placed"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for monitoring server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name in AWS"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "project9"
}
