resource "google_compute_network" "custom-network" {
  name                    = var.network-name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom-subnetwork" {
  name                     = "${google_compute_network.custom-network.name}-subnet-01"
  ip_cidr_range            = "10.2.0.0/16"
  network                  = google_compute_network.custom-network.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "custom-firewall-icmp" {
  name          = "${google_compute_network.custom-network.name}-firewall-01-icmp"
  network       = google_compute_network.custom-network.id
  direction     = "INGRESS"
  disabled      = false
  priority      = 100
  source_ranges = ["0.0.0.0"]
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "custom-firewall-tcp" {
  name          = "quangpham5-vm-01-network-01-firewall-01-tcp"
  network       = google_compute_network.custom-network.id
  direction     = "INGRESS"
  disabled      = false
  priority      = 100
  source_ranges = ["0.0.0.0"]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "3000-5000"]
  }
}

resource "google_compute_firewall" "custom-firewall-tcp-iap" {
  name    = "quangpham5-vm-01-network-01-firewall-01-tcp-iap"
  network = google_compute_network.custom-network.id
  allow {
    protocol = "tcp"
    ports    = ["22"] # for ssh
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name                      = var.vm-name
  machine_type              = "e2-micro"
  tags                      = ["http-server", "https-server"]
  allow_stopping_for_update = true
  metadata_startup_script   = "echo hi > /test.txt"
  boot_disk {
    auto_delete = true
    initialize_params {
      image = var.boot-image
      size  = 10
    }
  }
  network_interface {
    network    = google_compute_network.custom-network.name
    subnetwork = google_compute_subnetwork.custom-subnetwork.name
    access_config {
      // Ephemeral public IP
    }
  }
  scheduling {
    preemptible                 = true
    automatic_restart           = false
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
    on_host_maintenance         = "TERMINATE"
  }

  lifecycle {
    create_before_destroy = true
  }
}
