terraform {
  backend "gcs" {
    bucket = "terraform-demo-475117-tf-state"
    prefix = "terraform/scenarios/import-with-import-blocks"
  }
}

