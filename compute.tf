# Data source: latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.exam_key.key_name

  # Ensure instance gets a public IP (subnet has map_public_ip_on_launch true)
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y nginx1
              systemctl enable nginx
              systemctl start nginx
              cat > /usr/share/nginx/html/index.html <<HTML
              <h1>Project Genesis SUCCESS! Deployed by Komalpreet</h1>
              HTML
              EOF

  tags = {
    Name = "exam-web-server-komalpreet"
  }
}
