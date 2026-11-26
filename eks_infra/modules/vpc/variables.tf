variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  type = string
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
variable "enable_nat_gateway" {
  description = "Create a single NAT gateway so private subnets can reach the internet (costs money on real AWS)"
  type        = bool
  default     = false
}