# Assignment 2 - Multi-Tier Web Infrastructure

## 1. Project Overview
This project implements a multi-tier web infrastructure using AWS, Terraform, and Nginx.  
The architecture includes:

- Nginx as a reverse proxy and load balancer with caching.
- Multiple backend web servers (primary and backup).
- Security groups for network access control.
- Automated health checks and rate limiting.

## 1.1. Architecture Diagram
┌─────────────────────────────────────────────────┐
│                  Internet                       │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTPS (443)
                  │ HTTP (80)
                  ▼
         ┌────────────────────┐
         │   Nginx Server     │
         │  (Load Balancer)   │
         │   - SSL/TLS        │
         │   - Caching        │
         │   - Reverse Proxy  │
         └────────┬───────────┘
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
   ┌─────┐     ┌─────┐     ┌─────┐
   │Web-1│     │Web-2│     │Web-3│
   │     │     │     │     │(BKP)│
   └─────┘     └─────┘     └─────┘
   Primary     Primary     Backup

---

## 1.2. Components Description

| Component       | Description |
|-----------------|-------------|
| Nginx Server    | Reverse proxy, load balancer, caching, SSL/TLS termination |
| Web Servers     | Backend application servers (HTTPD) |
| Security Groups | Control inbound/outbound access |
| Terraform       | Infrastructure as code (provisioning EC2, SG, etc.) |
| Health Check    | Shell script monitoring backend server health |
| Rate Limiting   | Prevents abuse of web servers (429 responses) |

---

## 2. Prerequisites

- **Required Tools**:
  - Terraform >= 1.5
  - AWS CLI
  - SSH client
  - cURL (for testing)

- **AWS Setup**:
  - Configure credentials: `aws configure`
  - Ensure IAM user has EC2, VPC, SecurityGroup permissions

- **SSH Key Setup**:
  - Generate key pair: `ssh-keygen -t ed25519`
  - Store private key securely
  - Public key used in Terraform EC2 provisioning

---

## 3. Deployment Instructions

3.1  **Clone the project**:
```bash
git clone <repo-url>
cd Assignment2

3.2: Configure variables in terraform.tfvars:
env_prefix = "prod"
vpc_id = "<your-vpc-id>"
subnet_id = "<your-subnet-id>"
security_group_id = "<nginx-sg-id>"
instance_name = "webserver"
instance_suffix = "01"
public_key = "~/.ssh/id_ed25519.pub"
script_path = "scripts/user_data.sh"
common_tags = {
  Project = "Assignment2"
  Owner = "Prod"
}
3.3: initialize terraform: terraform init
3.4: Plan and Apply
terraform plan
terraform apply -auto-approve
4. Configuration Guide

Backend IPs: Update modules/networking/main.tf upstream block.

Nginx Configuration:

Reverse proxy: proxy_pass http://backend_pool;

Caching: proxy_cache mycache;

Rate limiting: limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;

Custom Error Pages: Place in /usr/share/nginx/html/errors/ and configure error_page in nginx.conf
5. Architecture Details

Network Topology:

Public Nginx server in subnet with Internet access

Private backend servers

Security Groups:

Nginx SG: Allows 80/443 from Internet

Backend SG: Allows 80 from Nginx only

Load Balancing: Nginx distributes requests across backend_pool servers, using primary + backup
6. Troubleshooting

Common Issues:

X-Cache-Status: BYPASS → check permissions on /var/cache/nginx and nginx user ownership

curl SSL errors → trust self-signed certificate locally

502 errors → backend servers down

Log Locations:
/var/log/nginx/access.log
/var/log/nginx/error.log
/home/ec2-user/backend_health.log
Debug Commands:
sudo nginx -t           # Test Nginx config
sudo systemctl status nginx
sudo tail -f /var/log/nginx/error.log
ps aux | grep nginx
