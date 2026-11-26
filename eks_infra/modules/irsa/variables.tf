variable "name" {
  type = string
}

variable "oidc_issuer_url" {
  description = "Cluster OIDC issuer URL from the eks module"
  type        = string
}

variable "thumbprint_list" {
  description = "Root CA thumbprint for the OIDC provider"
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

variable "roles" {
  description = "Roles to create, keyed by a short name"
  type = map(object({
    namespace       = string
    service_account = string
    policy_json     = string
  }))
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  issuer_host = replace(var.oidc_issuer_url, "https://", "")
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = var.oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.thumbprint_list
}

resource "aws_iam_role" "this" {
  for_each = var.roles

  name = "${var.name}-${each.key}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRoleWithWebIdentity"
      Principal = { Federated = aws_iam_openid_connect_provider.this.arn }
      Condition = {
        StringEquals = {
          "${local.issuer_host}:sub" = "system:serviceaccount:${each.value.namespace}:${each.value.service_account}"
          "${local.issuer_host}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "this" {
  for_each = var.roles

  name   = "${var.name}-${each.key}"
  policy = each.value.policy_json
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.roles

  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.this[each.key].arn
}