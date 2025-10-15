provider "google" {
  project = var.project_id
  region  = var.region
}

module "my_gcs_bucket" {
  source      = "./modules/gcs_bucket"
  bucket_name = var.bucket_name
  location    = var.region
  versioning  = true
  labels = {
    environment = "dev"
    owner       = "nishchya"
  }
}

