output "monitoring_instance_id" {
  description = "Monitoring server instance ID"
  value       = aws_instance.monitoring.id
}

output "monitoring_public_ip" {
  description = "Monitoring server public IP"
  value       = aws_instance.monitoring.public_ip
}

output "monitoring_private_ip" {
  description = "Monitoring server private IP"
  value       = aws_instance.monitoring.private_ip
}

output "monitoring_public_dns" {
  description = "Monitoring server public DNS"
  value       = aws_instance.monitoring.public_dns
}
