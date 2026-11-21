output "internal_alb_arn" {
  description = "ARN of the internal Application Load Balancer"
  value       = aws_lb.internal.arn
}

output "internal_alb_dns_name" {
  description = "DNS name of the internal Application Load Balancer"
  value       = aws_lb.internal.dns_name
}

output "internal_alb_zone_id" {
  description = "Route 53 hosted zone ID of the internal ALB"
  value       = aws_lb.internal.zone_id
}