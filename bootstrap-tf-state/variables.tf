variable "project_id" {
  description = "GCP Project ID that owns the state bucket"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "bucket_location" {
  description = "Location/region for the bucket (e.g., US, EU, ASIA)"
  type        = string
  default     = "US"
}

variable "state_bucket_name" {
  description = "Name of the Terraform state bucket"
  type        = string
}

