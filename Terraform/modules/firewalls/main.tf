resource "google_compute_firewall" "firewall_rules" {
  name    = var.name
  network = var.network

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target
}