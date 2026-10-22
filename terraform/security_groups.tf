# Create Security Group for Public EC2 Instances
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Allow inbound traffic for SSH and Web applications"
  vpc_id      = aws_vpc.main.id

  # 1. Allow SSH Access (Port 22)
  ingress {
    description = "Allow SSH from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["197.162.170.16/32", "197.49.173.224/32"] 
  }

  # 2. Allow HTTP Access (Port 80)
  ingress {
    description = "Allow HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # 4. Allow All Outbound Traffic (Egress)
  egress {
    description = "Allow all outbound traffic for updates and dependencies"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}


#-------------------------------------------------------

resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-db-sg"
  description = "Security Group for Database layer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow app to connect to DB"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] 
  }

  ingress {
    description = "Allow our team and ansible to SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["197.162.170.16/32", "197.49.173.224/32"]
  }

  egress {
    description = "To install packages, Docker pull and DB connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-db-sg"
  }
}
