resource "aws_lb" "internal" {
  name               = "project-03-internal-alb"
  internal           = true
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    "subnet-ca926ce8",
    "subnet-2380c5f1"
  ]

  tags = {
    Name        = "project-03-internal-alb"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}
