
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.internal.arn

  port     = 443
  protocol = "HTTPS"

  certificate_arn = aws_acm_certificate.api.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_app.arn
  }

  tags = {
    Name        = "project-03-https-listener"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}
