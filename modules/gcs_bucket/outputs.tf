output "bucket_url" {
  description = "The GCS bucket URL"
  value       = "gs://${google_storage_bucket.this.name}"
}

