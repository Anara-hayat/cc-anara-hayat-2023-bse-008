# Networking Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.this.id
}
