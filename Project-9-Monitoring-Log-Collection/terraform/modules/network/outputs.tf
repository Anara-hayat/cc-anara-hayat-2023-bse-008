output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "monitoring_sg_id" {
  description = "Monitoring security group ID"
  value       = aws_security_group.monitoring.id
}

output "app_sg_id" {
  description = "App servers security group ID"
  value       = aws_security_group.app.id
}
