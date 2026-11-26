output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "oidc_issuer_url" {
  description = "OIDC issuer used to build IRSA trust (null if the emulator doesn't return one)"
  value       = try(aws_eks_cluster.this.identity[0].oidc[0].issuer, null)
}

