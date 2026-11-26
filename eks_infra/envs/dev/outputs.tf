output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region} --endpoint-url ${var.floci_endpoint}"
}
output "api_invoke_url" {
  value = module.api_gateway.invoke_url
}

output "route53_zone_id" {
  value = module.route53.zone_id
}

output "flow_log_group" {
  value = module.flow_logs.log_group_name
}