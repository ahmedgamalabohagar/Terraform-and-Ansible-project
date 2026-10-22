data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name
  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "${var.project_name}-web-server"
  }
}

resource "aws_instance" "db_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size           = 20 # 20 GB dedicated disk space for DB
    volume_type           = "gp3"
    delete_on_termination = false 
  }
 
  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "${var.project_name}-db-server"
  }
}
