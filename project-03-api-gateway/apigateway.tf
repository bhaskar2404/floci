
resource "aws_apigatewayv2_api" "main" {
  name          = "enterprise-api"
  protocol_type = "HTTP"

  tags = {
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true

  tags = {
    Environment = "dev"
    Project     = "project-03-api-gateway"
  }
}

resource "aws_apigatewayv2_route" "get_orders" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "GET /orders"
  target    = "integrations/${aws_apigatewayv2_integration.alb.id}"

}




