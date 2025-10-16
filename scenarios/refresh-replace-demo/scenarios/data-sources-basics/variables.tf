variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for the VM"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Base name for the instance"
  type        = string
  default     = "ds-demo-vm"
}

variable "machine_type" {
  description = "GCE machine type"
  type        = string
  default     = "e2-micro"
}

variable "existing_bucket_name" {
  description = "Optional: name of an existing GCS bucket to upload a test object to"
  type        = string
  default     = ""
}

