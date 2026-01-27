variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet (monitoring server)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets (app servers)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "project9"
}

variable "your_ip" {
  description = "Your IP for SSH access"
  type        = string
  default     = "0.0.0.0/0"  # Change to your IP for security
}
