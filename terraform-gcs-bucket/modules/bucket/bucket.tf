variable "name" { type = string }

resource "google_storage_bucket" "this" {
  name     = var.name
  location = "ASIA-SOUTH1"
}

