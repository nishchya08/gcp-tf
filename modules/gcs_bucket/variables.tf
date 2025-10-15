variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "location" {
  description = "Location of the bucket"
  type        = string
}

variable "versioning" {
  description = "Enable object versioning"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the bucket"
  type        = map(string)
  default     = {}
}

