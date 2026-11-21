resource "aws_lb_target_group" "eks_app" {
  name        = "project-03-eks-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-2fe5fe3c"

  health_check {
    enabled             = true
    path                = "/orders/"
    protocol            = "HTTP"
    port                = "traffic-port"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "project-03-eks-app-tg"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}