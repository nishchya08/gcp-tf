terraform {
  backend "gcs" {
    bucket = "terraform-demo-475117-tf-state"
    prefix = "terraform/scenarios/data-sources-basics"
  }
}

