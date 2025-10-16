terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
  }
}

provider "google" {
  project = var.project_id
}

# Config must MATCH the real bucket, otherwise plan will show drift.
resource "google_storage_bucket" "b" {
  name                        = var.bucket_name
  location                    = "US-CENTRAL1"             # <- adjust to your bucket's location
  uniform_bucket_level_access = true
  force_destroy               = true

  versioning { enabled = true }

  labels = {
    managed_by = "terraform"
    env        = "import-demo"
  }
}

output "bucket_url" {
  value = "gs://${google_storage_bucket.b.name}"
}

