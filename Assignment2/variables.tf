variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "me-central-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "Invalid VPC CIDR block"
  }
}

variable "subnet_cidr_block" {
  description = "CIDR block for subnet"
  type        = string
  validation {
    condition     = can(cidrnetmask(var.subnet_cidr_block))
    error_message = "Invalid subnet CIDR block"
  }
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "env_prefix" {
  description = "Environment prefix"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_key" {
  description = "Path to public SSH key"
  type        = string
}

variable "private_key" {
  description = "Path to SSH private key"
  type        = string
}
