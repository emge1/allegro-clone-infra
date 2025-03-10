resource "aws_instance" "backend" {
  ami = "ami-03074cc1b166e8691"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_backend.id

  security_groups = [
    aws_security_group.backend_sg.id
  ]

  tags = {
    Name = "${var.project_name}-backend"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y python3 python3-pip
    pip3 install gunicorn django
    echo "Backend setup complete!"
  EOF
}

resource "aws_security_group" "backend_sg" {
  name = "${var.project_name}-backend-sg"
  description = "Allow traffic from reverse proxy to backend"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8000
    protocol  = "tcp"
    to_port   = 8000
    security_groups = [aws_security_group.reverse_proxy_sg.id]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-backend-sg"
  }
}