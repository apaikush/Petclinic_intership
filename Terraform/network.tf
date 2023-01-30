resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "jenkins_sub" {
  name          = "jenkins-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "app" {
  name          = "app-subnetwork"
  ip_cidr_range = "10.1.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}