variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment (dev/staging/production)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "project9"
}

variable "your_ip" {
  description = "Public IP for SSH/HTTP access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "app_server_count" {
  description = "Number of app servers"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
