# (Optional) keep provider constraints loose to match your installed version
terraform {
  required_version = ">= 1.5.0"
}

locals {
  config = yamldecode(file(var.config_file))

  project_id = local.config.project_id
  region     = try(local.config.region, "us-central1")

  bucket_name  = local.config.gcs_bucket.name
  bucket_loc   = try(local.config.gcs_bucket.location, local.region)
  bucket_tags  = try(local.config.gcs_bucket.labels, {})
  bucket_ver   = try(local.config.gcs_bucket.versioning, false)
}

provider "google" {
  project = local.project_id
  region  = local.region
}

module "gcs" {
  source      = "../../modules/gcs_bucket"  # <-- use shared module at repo root
  bucket_name = local.bucket_name
  location    = local.bucket_loc
  versioning  = local.bucket_ver
  labels      = local.bucket_tags
}


