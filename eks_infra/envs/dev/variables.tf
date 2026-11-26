variable "region" {
  type    = string
  default = "us-east-1"
}

variable "floci_endpoint" {
  type    = string
  default = "http://localhost:4566"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

# ---------- Network ----------
variable "vpc_cidr" {
  type = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

# ---------- EKS ----------
variable "kubernetes_version" {
  type = string
}

variable "node_instance_types" {
  type = list(string)
}

variable "node_desired_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

# ---------- Extras ----------
variable "api_backend_url" {
  type = string
}

variable "private_zone_name" {
  type = string
}

variable "flow_log_retention_days" {
  type    = number
  default = 14
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "enable_irsa" {
  type    = bool
  default = false
}

variable "ecr_repositories" {
  type = list(string)
}
