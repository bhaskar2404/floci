variable "project_name" {
  description = "Name  of the project"
  type        = string
  default     = "enterprise-vpc"
}

variable "vpc_cidr" {
  description = "IP address range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Public subnet IP Address"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private Subnet IP address"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
