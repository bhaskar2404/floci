variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "traffic_type" {
  description = "ACCEPT, REJECT or ALL"
  type        = string
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.traffic_type)
    error_message = "traffic_type must be ACCEPT, REJECT or ALL."
  }
}

variable "retention_days" {
  type    = number
  default = 14
}