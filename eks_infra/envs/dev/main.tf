locals {
  name = "${var.project}-${var.environment}"
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = local.name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
}

module "flow_logs" {
  source = "../../modules/vpc-flow-logs"

  name           = local.name
  vpc_id         = module.vpc.vpc_id
  retention_days = var.flow_log_retention_days
}

module "sg_cluster" {
  source = "../../modules/security-group"

  name        = "${local.name}-eks-extra"
  description = "Additional EKS control plane access"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "HTTPS from inside the VPC"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  ]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "${local.name}-eks"
  kubernetes_version = var.kubernetes_version
  subnet_ids         = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  node_subnet_ids    = module.vpc.private_subnet_ids
  security_group_ids = [module.sg_cluster.id]

  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  name        = local.name
  backend_url = var.api_backend_url
}

module "route53" {
  source = "../../modules/route53"

  zone_name = var.private_zone_name
  vpc_id    = module.vpc.vpc_id

  records = {
    api = {
      name    = "api.${var.private_zone_name}"
      type    = "CNAME"
      records = ["example.com"]
    }
  }
}

module "ecr" {
  source       = "../../modules/ecr"
  repositories = var.ecr_repositories
}

module "irsa" {
  count  = var.enable_irsa ? 1 : 0
  source = "../../modules/irsa"

  name            = local.name
  oidc_issuer_url = module.eks.oidc_issuer_url

  roles = {
    aws-load-balancer-controller = {
      namespace       = "kube-system"
      service_account = "aws-load-balancer-controller"
      policy_json     = file("${path.module}/policies/aws-load-balancer-controller.json")
    }
  }
}