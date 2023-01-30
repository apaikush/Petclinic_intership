variable "name" {
  type        = string
  description = "Firewall name"
}

variable "network" {
  description = "Network path"
}

variable "target" {
  type        = list(string)
  description = "Instance target tags"
}

variable "protocol" {
  type        = string
  description = "specified protocol"
  default     = "tcp"
}

variable "ports" {
  type        = list
  description = "Allowed ports"
  default     = ["8080"]
}

variable "source_ranges" {
  type        = list
  description = "IP source ranges"
  default     = ["0.0.0.0/0"]
}
