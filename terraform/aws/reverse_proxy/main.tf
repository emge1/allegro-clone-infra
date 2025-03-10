resource "aws_instance" "reverse_proxy" {
  ami = "ami-03074cc1b166e8691"
  instance_type = "t2.micro"
  key_name = var.ssh_key_name
  subnet_id = "aws_subnet.public.id"

  security_groups = [
    aws_security_group.reverse_proxy_sg.id
  ]

  tags = {
    Name = "${var.project_name}-reverse-proxy"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    ufw allow 'Nginx Full'
    systemctl enable nginx
    systemctl start nginx
  EOF
}

resource "aws_security_group" "reverse_proxy_sg" {
  name = "${var.project_name}-reverse-proxy-sg"
  description = "Allow HTTP and HTTPS traffic to reverse proxy"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-reverse-proxy-sg"
  }
}