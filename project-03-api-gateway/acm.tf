
resource "aws_acm_certificate" "api" {
  domain_name       = "api.vanamonline.com"
  validation_method = "DNS"

  tags = {
    Name        = "api-vanamonline-certificate"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }

  lifecycle {
    create_before_destroy = true
  }
}
