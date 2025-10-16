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

variable "project_id" {
  type        = string
  description = "Your GCP Project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "bucket_base" {
  type    = string
  default = "nishchya-refresh-replace-demo"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "google_storage_bucket" "demo" {
  name                        = "${var.bucket_base}-${random_id.suffix.hex}"
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true

  versioning { enabled = true }

  labels = {
    env        = "dev"
    managed_by = "terraform"
  }
}

output "bucket_name" {
  value = google_storage_bucket.demo.name
}

