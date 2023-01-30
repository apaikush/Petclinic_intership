variable "name" {
  type        = string
  description = "VM name"
}

variable "tags" {
  type        = list(string)
  description = "Intace tags"
  default     = []
}

variable "machine_type" {
  type        = string
  description = "Machine type"
  default     = "e2-medium"
}

variable "zone" {
  type        = string
  description = "VM zone"
  default     = "europe-west1-b"
}

variable "boot_disk" {
  type        = string
  description = "Boot disk"
  default     = "centos-cloud/centos-7"
}

variable "subnetwork" {
  description = "Subnetwork path"
  default     = "google_compute_subnetwork.jenkins_sub.id"
}

variable "network" {
  description = "Network to deploy to"
  type        = string
  default     = ""
}


variable ssh_pub_key {
    type        = string
    description = "public ssh key"
}

variable ssh_user {
    type        = string
    description = "ssh user"
}
#variable "startup_script"{
#    type = string
#}
