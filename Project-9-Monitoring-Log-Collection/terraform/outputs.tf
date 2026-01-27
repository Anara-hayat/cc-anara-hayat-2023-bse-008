output "monitoring_server_public_ip" {
  description = "Public IP of monitoring server"
  value       = module.monitoring_server.monitoring_public_ip
}

output "monitoring_server_public_dns" {
  description = "Public DNS of monitoring server"
  value       = module.monitoring_server.monitoring_public_dns
}

output "monitoring_server_private_ip" {
  description = "Private IP of monitoring server"
  value       = module.monitoring_server.monitoring_private_ip
}

output "app_servers_private_ips" {
  description = "Private IPs of app servers"
  value       = module.app_servers.app_private_ips
}

output "app_server_count" {
  description = "Number of app servers"
  value       = var.app_server_count
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}
