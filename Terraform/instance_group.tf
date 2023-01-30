resource "google_compute_instance_group" "jenkins" {
  name    = "my-jenkins-group"
  zone    = var.zone
  project = var.project

  named_port {
    name = "http"
    port = "8080"
  }

  instances = [
    module.VM1.instanceID
  ]
}

resource "google_compute_instance_group" "nexus" {
  name    = "my-nexus-group"
  zone    = var.zone
  project = var.project

  named_port {
    name = "http"
    port = "8080"
  }

  instances = [
    module.VM3.instanceID
  ]
}