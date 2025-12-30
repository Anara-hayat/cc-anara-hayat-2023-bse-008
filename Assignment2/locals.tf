data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  my_ip = "${chomp(data.http.my_ip.response_body)}/32"

  common_tags = {
    Project     = "Assignment-2"
    Environment = var.env_prefix
    ManagedBy   = "Terraform"
  }

  backend_servers = [
    { name = "web-1", suffix = "1", script_path = "./scripts/apache-setup.sh" },
    { name = "web-2", suffix = "2", script_path = "./scripts/apache-setup.sh" },
    { name = "web-3", suffix = "3", script_path = "./scripts/apache-setup.sh" }
  ]
}
