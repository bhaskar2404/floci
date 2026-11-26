terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_route53_zone" "this" {
  name = var.zone_name

  dynamic "vpc" {
    for_each = var.vpc_id == null ? [] : [var.vpc_id]
    content {
      vpc_id = vpc.value
    }
  }
}

resource "aws_route53_record" "this" {
  for_each = var.records

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}