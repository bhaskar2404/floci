variable "zone_name" {
  description = "e.g. demo.internal (private) or example.com (public)"
  type        = string
}

variable "vpc_id" {
  description = "Set for a private hosted zone; leave null for a public zone"
  type        = string
  default     = null
}

variable "records" {
  description = "Map of DNS records keyed by a unique label"
  type = map(object({
    name    = string
    type    = string
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}