output "app_instance_ids" {
  description = "App server instance IDs"
  value       = aws_instance.app[*].id
}

output "app_private_ips" {
  description = "App server private IPs"
  value       = aws_instance.app[*].private_ip
}

output "app_instances" {
  description = "All app server instances"
  value       = aws_instance.app[*]
}
