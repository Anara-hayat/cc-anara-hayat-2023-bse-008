# Project 9: Infrastructure Monitoring and Log Collection System

## Overview

Project 9 is a comprehensive **Infrastructure as Code (IaC)** solution that automates the deployment and monitoring of cloud infrastructure on AWS. The system provisions a centralized monitoring server, multiple application servers, and provides real-time visibility into system health through a web-based dashboard.

### Key Features

- ✅ **Fully Automated Infrastructure**: Terraform-based provisioning of AWS resources
- ✅ **Server Configuration**: Ansible-driven setup and configuration management
- ✅ **Real-Time Monitoring**: Automated metrics collection (CPU, Memory, Disk, Load)
- ✅ **Service Health Checks**: Continuous monitoring of critical services (Nginx, SSH)
- ✅ **HTTP Endpoint Verification**: Regular health checks on application servers
- ✅ **Centralized Dashboard**: Web-based visualization of system status
- ✅ **Log Collection**: Automated aggregation of application logs
- ✅ **Automated Reporting**: Daily and weekly monitoring reports

---

## Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Cloud Platform | Amazon Web Services (AWS) | Current |
| Infrastructure as Code | Terraform | v1.0+ |
| Configuration Management | Ansible | v2.10+ |
| Web Server | Nginx | Latest |
| Monitoring Scripts | Bash Shell | - |
| Version Control | Git/GitHub | - |
| Python | Python | 3.9+ |

---

## Architecture

### System Components

```
┌─────────────────────────────────────────────────────────────┐
│                          AWS VPC (10.0.0.0/16)              │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         Public Subnet (10.0.1.0/24)                  │  │
│  │  ┌─────────────────────────────────────────────────┐ │  │
│  │  │  Monitoring Server (EC2)                         │ │  │
│  │  │  - Nginx Dashboard                               │ │  │
│  │  │  - Monitoring Scripts (Cron)                     │ │  │
│  │  │  - Log Collection                                │ │  │
│  │  │  - Report Generation                             │ │  │
│  │  │  Public IP: 35.170.79.101                        │ │  │
│  │  └─────────────────────────────────────────────────┘ │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         Private Subnets (10.0.10/11.0.0/24)         │  │
│  │  ┌─────────────────────┐  ┌─────────────────────┐   │  │
│  │  │  App Server 1       │  │  App Server 2       │   │  │
│  │  │  - Nginx (Port 80)  │  │  - Nginx (Port 80)  │   │  │
│  │  │  - /health endpoint │  │  - /health endpoint │   │  │
│  │  │  - Logs             │  │  - Logs             │   │  │
│  │  │  10.0.10.25         │  │  10.0.11.105        │   │  │
│  │  └─────────────────────┘  └─────────────────────┘   │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Metrics Collection** → Monitoring server collects CPU, memory, disk, and load data
2. **Service Monitoring** → Checks if Nginx and SSH services are running
3. **HTTP Health Checks** → Verifies app server availability via `/health` endpoint
4. **Log Aggregation** → Gathers Nginx access and error logs
5. **Report Generation** → Creates daily and weekly monitoring reports
6. **Dashboard Update** → Updates web dashboard with latest data (every 5 minutes)

---

## Quick Start

### Prerequisites

- AWS Account with appropriate permissions
- Local machine with Linux/Mac/WSL2
- Git, Terraform, Ansible, AWS CLI installed
- SSH keypair for AWS access

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/CC_YourName_RollNumber_Project9.git
cd CC_YourName_RollNumber_Project9

# 2. Configure AWS credentials
aws configure
# Enter: Access Key, Secret Key, Region (us-east-1), Output (json)

# 3. Create SSH key for AWS
ssh-keygen -t rsa -b 4096 -f ~/.ssh/project9-key -N ""

# 4. Deploy infrastructure
cd terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars

# Save the outputs
terraform output > outputs.txt

# 5. Configure servers
cd ../ansible
ansible-playbook -i inventory/dev_aws_ec2.yml playbooks/configure-monitoring-server.yml -v

# 6. Access dashboard
# Open browser: http://<monitoring_server_public_ip>
```

---

## Project Structure

```
Project9/
├── README.md                          # This file
├── .gitignore                         # Git ignore rules
├── terraform/                         # Infrastructure code
│   ├── main.tf                        # Root configuration
│   ├── variables.tf                   # Input variables
│   ├── outputs.tf                     # Output values
│   ├── backend.tf                     # State configuration
│   ├── environments/
│   │   ├── dev.tfvars                 # Development environment
│   │   ├── staging.tfvars
│   │   └── production.tfvars
│   └── modules/
│       ├── network/                   # VPC, subnets, security groups
│       ├── monitoring-server/         # Monitoring EC2 instance
│       └── app-servers/               # Application EC2 instances
├── ansible/                           # Configuration management
│   ├── ansible.cfg                    # Ansible configuration
│   ├── inventory/
│   │   └── dev_aws_ec2.yml            # Dynamic inventory
│   ├── playbooks/
│   │   ├── configure-monitoring-server.yml
│   │   ├── configure-app-servers.yml
│   │   └── collect-logs.yml
│   └── roles/
│       ├── dashboard/                 # Nginx dashboard setup
│       ├── nginx-app/                 # App server Nginx config
│       └── monitoring-tools/          # Monitoring scripts & cron
│           └── files/
│               ├── collect-metrics.sh
│               ├── check-services.sh
│               ├── http-health-check.sh
│               ├── generate-report.sh
│               └── build-dashboard.sh
├── scripts/                           # Utility scripts
├── web-ui/                            # Dashboard HTML/CSS/JS
│   ├── index.html
│   └── assets/
├── docs/                              # Documentation
│   └── incident-procedures.md         # Incident response guide
└── logs/                              # Collected logs directory
```

---

## Monitoring System

### What Gets Monitored

| Metric | Collection Interval | Location |
|--------|-------------------|----------|
| CPU Usage | Every 5 minutes | `/var/www/html/reports/latest-metrics.txt` |
| Memory Usage | Every 5 minutes | `/var/www/html/reports/latest-metrics.txt` |
| Disk Usage | Every 5 minutes | `/var/www/html/reports/latest-metrics.txt` |
| Service Status (Nginx, SSH) | Every 5 minutes | `/var/www/html/reports/service-status.txt` |
| HTTP Health Checks | Every 5 minutes | `/var/www/html/reports/health-checks.txt` |
| Daily Reports | Daily at 11:59 PM | `/var/www/html/reports/daily-YYYY-MM-DD.txt` |
| Weekly Reports | Daily at 11:59 PM | `/var/www/html/reports/weekly-YYYY-WXX.txt` |

### Monitoring Scripts

1. **collect-metrics.sh** - Gathers CPU, memory, disk, and load average
2. **check-services.sh** - Verifies Nginx and SSH are running
3. **http-health-check.sh** - Tests HTTP `/health` endpoint on app servers
4. **generate-report.sh** - Creates daily and weekly summary reports
5. **build-dashboard.sh** - Generates HTML dashboard with latest data

All scripts are scheduled via cron and run automatically without manual intervention.

---

## Dashboard

The monitoring dashboard is accessible at: `http://<monitoring_server_public_ip>`

### Dashboard Sections

- **System Metrics**: Real-time CPU, memory, disk, and load statistics
- **Service Status**: Current status of Nginx and SSH services
- **Health Checks**: HTTP response status for each application server
- **Reports**: Links to latest metrics, service status, health checks, and historical reports

The dashboard auto-refreshes every 30 seconds and displays the last update timestamp.

---

## Log Collection

### Logs Collected

- **Nginx Access Logs**: Records every HTTP request
- **Nginx Error Logs**: Captures server errors and warnings

### Log Location

Logs are collected from application servers and stored on the monitoring server:
```
/var/www/html/reports/collected-logs/
├── 10.0.10.25/
│   ├── access.log
│   └── error.log
└── 10.0.11.105/
    ├── access.log
    └── error.log
```

---

## Common Commands

### Terraform Commands

```bash
cd terraform

# Initialize
terraform init

# Plan changes
terraform plan -var-file=environments/dev.tfvars

# Apply infrastructure
terraform apply -var-file=environments/dev.tfvars

# View outputs
terraform output

# Destroy infrastructure
terraform destroy -var-file=environments/dev.tfvars
```

### Ansible Commands

```bash
cd ansible

# List all hosts
ansible-inventory -i inventory/dev_aws_ec2.yml --list

# Test connectivity
ansible all -i inventory/dev_aws_ec2.yml -m ping

# Run playbook
ansible-playbook -i inventory/dev_aws_ec2.yml playbooks/configure-monitoring-server.yml -v
```

### Monitoring Commands

```bash
# SSH into monitoring server
ssh -i ~/.ssh/project9-key ubuntu@<public_ip>

# Check cron jobs
sudo crontab -l

# View latest metrics
cat /var/www/html/reports/latest-metrics.txt

# View service status
cat /var/www/html/reports/service-status.txt

# View health checks
cat /var/www/html/reports/health-checks.txt

# Run monitoring script manually
sudo /usr/local/bin/collect-metrics.sh
```

---

## Troubleshooting

### Common Issues

**Q: Dashboard shows no data**
- Wait 5 minutes for cron jobs to execute
- Check monitoring scripts: `sudo systemctl status cron`
- Verify scripts have execute permissions: `ls -la /usr/local/bin/*metrics*`

**Q: Health checks showing DOWN**
- Verify app servers are running: `ssh ubuntu@10.0.10.25 sudo systemctl status nginx`
- Check security groups allow traffic from monitoring server
- Test manually: `curl http://10.0.10.25/health`

**Q: Cannot SSH to app servers**
- Verify SSH key permissions: `chmod 600 ~/.ssh/project9-key`
- Check security group allows SSH from your IP
- Confirm instance is running: Check AWS console

**Q: Terraform plan shows errors**
- Verify AWS credentials: `aws sts get-caller-identity`
- Check region in variables.tf matches configuration
- Ensure no resources are already created manually

---

## Features & Capabilities

### Infrastructure Management
- Automated provisioning of VPC, subnets, security groups, and EC2 instances
- Multi-environment support (dev, staging, production)
- Reusable Terraform modules
- State file management

### Configuration Management
- Automated Nginx installation and configuration
- Dynamic inventory using AWS tags
- Ansible roles for different server types
- Handler-based service management

### Monitoring & Observability
- Real-time system metrics collection
- Service health verification
- HTTP endpoint availability checks
- Historical data retention
- Automated report generation

### Scalability
- Easy to add more app servers (change count variable)
- Modular architecture allows customization
- Infrastructure and configuration as code enables reproducibility

---

## Performance & Reliability

- **Monitoring Frequency**: Every 5 minutes
- **Report Generation**: Daily and weekly
- **Dashboard Refresh Rate**: Every 30 seconds
- **Data Retention**: 30 days
- **Uptime Target**: 99.9%

---

## Future Enhancements

### Short-term
- Add email notifications for critical alerts
- Implement HTTPS with SSL certificates
- Add basic authentication to dashboard

### Medium-term
- Integrate Prometheus and Grafana for advanced metrics
- Implement ELK stack for centralized logging
- Add container monitoring support

### Long-term
- Automated remediation for common issues
- Machine learning-based anomaly detection
- Integration with ChatOps platforms

---

## Security Considerations

- SSH access restricted to known IPs
- Private subnets for app servers with NAT Gateway
- Security groups restrict traffic to necessary ports
- IAM roles for EC2 instances
- Sensitive data excluded from version control (.gitignore)

---

## Contributing

1. Clone the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## Incident Response

For detailed incident procedures and troubleshooting steps, refer to `docs/incident-procedures.md`.

---

## Support & Documentation

- **Main Documentation**: `/docs/`
- **Incident Procedures**: `/docs/incident-procedures.md`
- **Project Report**: `Project9_YourName_RollNumber.pdf`

---

## Author

**Name**: Aimen Hafeez 
**Roll Number**: 2023-BSE-002  
**Name**: Arooj Saleem 
**Roll Number**: 2023-BSE-013  
**Name**: Anara Hayat
**Roll Number**: 2023-BSE-008  
**Institution**: Fatima Jinnah Women University

---

## License

This project is provided as-is for educational purposes.

---

## Acknowledgments

This project demonstrates practical Cloud Computing practices including Infrastructure as Code, Configuration Management, and Systems Monitoring using industry-standard tools and cloud platforms.