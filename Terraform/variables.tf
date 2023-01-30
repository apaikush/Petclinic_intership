variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "project" {
  default = "gd-gcp-internship-lviv"
}

variable "authorized_networks" {
  default = [{
    name  = "sample-gcp-health-checkers-range"
    value = "130.211.0.0/28"
  }]
  type        = list(map(string))
  description = "List of mapped public networks authorized to access to the instances"
}

variable ssh_user {
    type        = string
    description = "ssh user"
    default = "apaikush"
}

variable db_password {
    type        = string
    description = "DB user password"
    # Need to add env veraible exmple: (export TF_VAR_EXAMPLE_ONE="<value>") to .bashrc, or .zshrc, configuration file:
}