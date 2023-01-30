resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags
  boot_disk {
    initialize_params {
      image = var.boot_disk
    }
  }

  #metadata_startup_script   = var.startup_script
  allow_stopping_for_update = true

  network_interface {
    subnetwork = var.subnetwork
    network = var.network
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_pub_key}"
  }
}