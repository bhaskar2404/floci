region         = "us-east-1"
floci_endpoint = "http://localhost:4566"
project        = "demo"
environment    = "dev"

# Network
vpc_cidr             = "10.0.0.0/16"
azs                  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

# EKS
kubernetes_version  = "1.30"
node_instance_types = ["t3.medium"]
node_desired_size   = 2
node_min_size       = 1
node_max_size       = 3

# Extras
api_backend_url         = "http://example.com"
private_zone_name       = "demo.internal"
flow_log_retention_days = 14

enable_nat_gateway = false # true on real AWS
enable_irsa        = false # try true on Floci; keep false if it errors
ecr_repositories   = ["web-app-v2"]