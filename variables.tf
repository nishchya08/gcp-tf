variable "region" {
  type    = string
  default = "us-central1"
}

variable "project_id" {
  type        = string
  description = "Your GCP Project ID"
}

variable "bucket_base" {
  type        = string
  default     = "nishchya-ws-demo"
  description = "Base name for GCS buckets"
}
