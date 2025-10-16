terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
  }
}

provider "google" {
  project = var.project_id
}

# Minimal resource that will be adopted by the import
resource "google_compute_firewall" "fw" {
  name      = "default-allow-ssh"   # adjust if you import a different rule
  network   = "default"
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"]
}

# -----------------------------
# IMPORT BLOCK (no variables!)
# ID format: projects/<PROJECT_ID>/global/firewalls/<FIREWALL_NAME>
# -----------------------------
import {
  to = google_compute_firewall.fw
  id = "projects/terraform-demo-475117/global/firewalls/default-allow-ssh"
}

