terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  env         = terraform.workspace
  env_suffix  = lower(replace(local.env, "/[^a-z0-9-]/", "-"))
  common_labels = {
    environment = local.env
    owner       = "nishchya"
    managed_by  = "terraform"
  }
}

module "my_gcs_bucket" {
  source      = "./modules/gcs_bucket"
  bucket_name = "${var.bucket_base}-${local.env_suffix}"  # e.g. nishchya-ws-demo-dev
  location    = var.region
  versioning  = true
  labels      = local.common_labels
}


