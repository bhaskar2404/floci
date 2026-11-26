variable "repositories" {
  type = list(string)
}

variable "keep_last_images" {
  type    = number
  default = 20
}

variable "enable_lifecycle_policy" {
  description = "Set false if the emulator rejects lifecycle policies"
  type        = bool
  default     = true
}