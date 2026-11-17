

data "aws_vpc" "existing" {
  id = var.vpc_id
}

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/enterprise-vpc/flow-logs"
  retention_in_days = 7

  tags = {
    Name        = "enterprise-vpc-flow-logs"
    Environment = var.environment
  }
}

resource "aws_iam_role" "vpc_flow_logs" {
  name               = "enterprise-vpc-flow-logs-role"
  assume_role_policy = file("${path.module}/iam-trust-policy.json")
  tags = {
    Name        = "enterprise-vpc-flow-logs-role"
    Environment = var.environment
  }
}



resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name = "enterprise-vpc-flow-logs-policy"
  role = aws_iam_role.vpc_flow_logs.id

  policy = file("${path.module}/iam-flow-logs-policy.json")
}


resource "aws_flow_log" "enterprise_vpc_flow_logs" {
  vpc_id               = data.aws_vpc.existing.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn

  tags = {
    Name        = "enterprise-vpc-flow-logs"
    Environment = var.environment
  }
}
