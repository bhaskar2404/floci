resource "aws_security_group" "alb_sg" {
  name        = "project-03-alb-sg"
  description = "Security group for internal ALB"
  vpc_id      = "vpc-2fe5fe3c"

  # Allow HTTPS traffic only from the VPC Link
  ingress {
    description     = "Allow HTTPS from VPC Link"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc_link_sg.id]
  }

  # Temporary outbound access for our lab
  # Later, we will restrict this to the EKS application.
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "project-03-alb-sg"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}
