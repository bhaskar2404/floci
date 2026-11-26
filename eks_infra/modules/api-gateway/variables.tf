variable "name" {
  type = string
}

variable "backend_url" {
  description = "Backend the API proxies to (e.g. an ALB/NLB URL or any HTTP endpoint)"
  type        = string
}

variable "stage_name" {
  type    = string
  default = "$default"
}