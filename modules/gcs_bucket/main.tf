terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# No provider block in module
resource "google_storage_bucket" "this" {
  name                        = var.name
  location                    = var.location
  uniform_bucket_level_access = true
  labels = merge(
    var.labels,
    { module_version = "v1.1.0" }  # new behavior for v1.1.0
  )
}

