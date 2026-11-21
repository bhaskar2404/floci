
resource "aws_security_group" "vpc_link_sg" {
  name        = "project-03-vpc-link-sg"
  description = "Security group for API Gateway VPC Link"
  vpc_id      = "vpc-2fe5fe3c"

  # Temporary outbound access for our lab.
  # We will tighten this when the ALB security group is ready.
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "project-03-vpc-link-sg"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}
