variable "bucket_name" {
  description = "Name of the bucket."
  type        = string
}

variable "location" {
  description = "Region or multi-region where the bucket will be created."
  type        = string
  default     = "US"
}

