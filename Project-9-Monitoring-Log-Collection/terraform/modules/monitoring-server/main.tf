# Read SSH public key
data "local_file" "ssh_public_key" {
  filename = pathexpand("~/.ssh/project9-key.pub")
}

# Monitoring Server EC2 Instance
resource "aws_instance" "monitoring" {
  ami                    = "ami-054d6a336762e438e"  
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  associate_public_ip_address = true

  # Initialize with Python 3.9 and SSH key setup
  user_data = base64encode(<<-EOF
              #!/bin/bash
              set -e
              
              # Update system
              apt-get update
              apt-get install -y python3.9 python3-pip curl net-tools htop
              update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
              
              # Setup SSH directory for ubuntu user
              mkdir -p /home/ubuntu/.ssh
              chmod 700 /home/ubuntu/.ssh
              
              # Add SSH public key
              echo '${data.local_file.ssh_public_key.content}' >> /home/ubuntu/.ssh/authorized_keys
              chmod 600 /home/ubuntu/.ssh/authorized_keys
              chown -R ubuntu:ubuntu /home/ubuntu/.ssh
              
              # Create web root for dashboard
              mkdir -p /var/www/html/reports
              chown -R www-data:www-data /var/www/html
              chmod 755 /var/www/html
              chmod 755 /var/www/html/reports
              
              echo "Monitoring server initialized successfully" > /tmp/init.log
              EOF
  )

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.project_name}-monitoring-server"
    Role        = "monitoring"
    Environment = var.environment
  }

  depends_on = []
}
