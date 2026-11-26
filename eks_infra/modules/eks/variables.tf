variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "subnet_ids" {
  description = "Subnets for the control plane"
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Subnets for worker nodes"
  type        = list(string)
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "security_group_ids" {
  description = "Extra security groups for the control plane ENIs"
  type        = list(string)
  default     = []
}