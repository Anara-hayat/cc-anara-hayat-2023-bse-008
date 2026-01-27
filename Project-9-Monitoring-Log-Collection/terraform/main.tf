terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Network Module
module "network" {
  source = "./modules/network"

  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidr    = "10.0.1.0/24"
  private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
  environment           = var.environment
  project_name          = var.project_name
  your_ip               = var.your_ip
}

# Monitoring Server Module
module "monitoring_server" {
  source = "./modules/monitoring-server"

  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.monitoring_sg_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  environment       = var.environment
  project_name      = var.project_name
}

# App Servers Module
module "app_servers" {
  source = "./modules/app-servers"

  subnet_ids         = module.network.private_subnet_ids
  security_group_id  = module.network.app_sg_id
  instance_count     = var.app_server_count
  instance_type      = var.instance_type
  key_name           = var.key_name
  environment        = var.environment
  project_name       = var.project_name
}
