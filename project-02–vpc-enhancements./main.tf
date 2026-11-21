

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

resource "aws_network_acl" "public" {
  vpc_id = data.aws_vpc.existing.id
  tags = {
    Name        = "enterprise-public-nacl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "public_inbound_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}


resource "aws_network_acl_rule" "public_inbound_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}


resource "aws_network_acl_rule" "public_inbound_ephemeral" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_outbound_ephemeral" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_outbound_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_outbound_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_association" "public_az_a" {
  network_acl_id = aws_network_acl.public.id
  subnet_id      = "subnet-6d014f03"
}

resource "aws_network_acl_association" "public_az_b" {
  network_acl_id = aws_network_acl.public.id
  subnet_id      = "subnet-1a442e87"
}