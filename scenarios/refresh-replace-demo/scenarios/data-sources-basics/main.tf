terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# ---------------------------
# DATA SOURCES (READ ONLY)
# ---------------------------

# Who/where am I authenticated as?
data "google_client_config" "current" {}

# The current project details (number, org/billing relations)
data "google_project" "current" {
  project_id = var.project_id
}

# Fetch the default VPC (created by GCP unless you deleted it)
data "google_compute_network" "default" {
  name = "default"
}

# Fetch default subnet in the chosen region (auto mode networks have it)
data "google_compute_subnetwork" "default" {
  name   = "default"
  region = var.region
}

# Latest Debian 12 image from public debian-cloud project
data "google_compute_image" "debian" {
  family  = "debian-12"
  project = "debian-cloud"
}

# Optional: reference an existing bucket by name (if provided)
data "google_storage_bucket" "existing" {
  count = var.existing_bucket_name == "" ? 0 : 1
  name  = var.existing_bucket_name
}

# ---------------------------
# RESOURCES (CREATE/CHANGE)
# ---------------------------

# Small random suffix for uniqueness
resource "random_id" "suffix" {
  byte_length = 2
}

# Create a tiny VM using the fetched image & default network/subnet
resource "google_compute_instance" "vm" {
  name         = "${var.instance_name}-${random_id.suffix.hex}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
      size  = 10
      type  = "pd-balanced"
    }
  }

  # Attach to the default network + region's default subnet
  network_interface {
    network    = data.google_compute_network.default.self_link
    subnetwork = data.google_compute_subnetwork.default.self_link

    # ephemeral external IP (comment this block to make it internal-only)
    access_config {}
  }

  labels = {
    env        = "dev"
    managed_by = "terraform"
  }

  metadata = {
    serial-port-enable = "1"
  }
}

# If an existing bucket name is provided, upload a tiny text object
resource "google_storage_bucket_object" "hello" {
  count   = var.existing_bucket_name == "" ? 0 : 1
  name    = "hello-from-terraform-${random_id.suffix.hex}.txt"
  bucket  = data.google_storage_bucket.existing[0].name
  content = "Hi ${data.google_client_config.current.project} from VM ${google_compute_instance.vm.name}\n"
}

