
resource "google_storage_bucket" "this" {
  name = var.bucket_name
  location = "US"
  force_destroy = true
}
 
