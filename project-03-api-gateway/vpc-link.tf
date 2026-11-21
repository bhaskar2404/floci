resource "aws_apigatewayv2_vpc_link" "main" {
  name = "project-03-vpc-link"

  subnet_ids = [
    "subnet-ca926ce8",
    "subnet-2380c5f1"
  ]

  security_group_ids = [
    aws_security_group.vpc_link_sg.id
  ]

  tags = {
    Name        = "project-03-vpc-link"
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}