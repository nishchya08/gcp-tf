# Enable provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# (Optional but recommended) ensure the Storage API is enabled
resource "google_project_service" "storage_api" {
  project = var.project_id
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

# Manage the existing TF state bucket
resource "google_storage_bucket" "tf_state" {
  name                        = var.state_bucket_name         # <-- terraform-demo-475117-tf-state
  location                    = var.bucket_location           # e.g., "US"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action { type = "Delete" }
    condition {
      num_newer_versions = 30  # keep last 30 versions
    }
  }

  labels = {
    purpose = "terraform-state"
    owner   = "nishchya"
  }

  # Prevent accidental bucket destroy
  force_destroy = false
}

output "state_bucket_name" {
  value = google_storage_bucket.tf_state.name
}

