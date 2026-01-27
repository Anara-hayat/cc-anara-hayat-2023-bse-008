variable "subnet_ids" {
  description = "List of subnet IDs for app servers"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for app servers"
  type        = string
}

variable "instance_count" {
  description = "Number of app servers to create"
  type        = number
  default     = 2
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
