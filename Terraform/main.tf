provider "google" {
  credentials = file("/Users/apaikush/Downloads/gd-gcp-internship-lviv-fcfdd483aa6c.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

module "VM1" {
  source     = "./modules/vm_instane"
  name       = "jenkins-master"
  tags       = ["jenkins-master","web1", "sub1"]
  subnetwork = google_compute_subnetwork.jenkins_sub.id
  ssh_pub_key  = data.tls_public_key.jenkins_public_key.public_key_openssh
  ssh_user      = var.ssh_user
}

module "VM2" {
  source     = "./modules/vm_instane"
  name       = "jenkins-agent"
  tags       = ["agent", "web1", "sub1"]
  subnetwork = google_compute_subnetwork.jenkins_sub.id
  ssh_pub_key  = data.tls_public_key.jenkins_public_key.public_key_openssh
  ssh_user      = var.ssh_user
}

module "VM3" {
  source     = "./modules/vm_instane"
  name       = "nexus"
  tags       = ["nexus", "web1", "sub1"]
  subnetwork = google_compute_subnetwork.jenkins_sub.id
  ssh_pub_key  = data.tls_public_key.jenkins_public_key.public_key_openssh
  ssh_user      = var.ssh_user
}

module "VM4" {
  source     = "./modules/vm_instane"
  name       = "application"
  tags       = ["app", "web1", "sub2"]
  subnetwork = google_compute_subnetwork.app.id
  ssh_pub_key  = data.tls_public_key.jenkins_public_key.public_key_openssh
  ssh_user      = var.ssh_user
}

module "firewall_allow_all2" {
  source  = "./modules/firewalls"
  name    = "allow-test-terr2"
  network = google_compute_network.vpc_network.id
  target  = ["app", "nexus"]
}

module "firewall-ssh" {
  source  = "./modules/firewalls"
  name    = "allow-ssh-terr"
  network = google_compute_network.vpc_network.id
  target  = ["web1"]
  ports   = ["22"]
}

module "firewall-nexus" {
  source  = "./modules/firewalls"
  name    = "allow-8081-terr"
  network = google_compute_network.vpc_network.id
  target  = ["nexus"]
  ports   = ["8081", "8085"]
}


