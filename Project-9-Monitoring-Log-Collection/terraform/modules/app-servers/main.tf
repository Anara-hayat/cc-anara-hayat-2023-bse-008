# App Servers
resource "aws_instance" "app" {
  count                  = var.instance_count
  ami                    = "ami-054d6a336762e438e" 
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  associate_public_ip_address = false
  
  # Install Python 3.9 on startup
  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3.9 python3-pip
              update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
              EOF
  )

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.project_name}-app-server-${count.index + 1}"
    Role        = "app"
    Environment = var.environment
  }
}
