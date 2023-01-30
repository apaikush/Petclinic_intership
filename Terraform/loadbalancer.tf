resource "google_compute_health_check" "default" {
  name               = "healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1

  http_health_check {
    port         = 8080
    request_path = "/jenkins/login"
  }
}

resource "google_compute_health_check" "nexus" {
  name               = "healthcheck-nexus"
  timeout_sec        = 1
  check_interval_sec = 1

  http_health_check {
    port         = 8080
    request_path = "/"
  }
}

resource "google_compute_backend_service" "jenkins" {
  name          = "backend-service-jenkins"
  port_name     = "http"
  protocol      = "HTTP"
  health_checks = ["${google_compute_health_check.default.self_link}"]
  backend {
    group                 = google_compute_instance_group.jenkins.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }

  depends_on = [
    google_compute_instance_group.jenkins
  ]
}

resource "google_compute_backend_service" "nexus" {
  name          = "backend-service-nexus"
  port_name     = "http"
  protocol      = "HTTP"
  health_checks = ["${google_compute_health_check.nexus.self_link}"]
  backend {
    group                 = google_compute_instance_group.nexus.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }

  depends_on = [
    google_compute_instance_group.jenkins
  ]
}

resource "google_compute_url_map" "url_map" {
  name            = "load-balancer"
  default_service = google_compute_backend_service.jenkins.self_link

 host_rule {
    hosts        = ["*"]
    path_matcher = "mysite"
  }

path_matcher {
    name            = "mysite"
    default_service = google_compute_backend_service.jenkins.id
   path_rule {
      paths   = ["/jenkins"]
      service = google_compute_backend_service.jenkins.id
    }
     path_rule {
      paths   = ["/nx"]
      service = google_compute_backend_service.nexus.id
    }
}
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  name    = "proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = "global-forwarding-rule"
  target     = google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "8080"
}