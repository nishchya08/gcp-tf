variable "project_id" {
  description = "Your GCP project ID"
  type        = string
}

variable "firewall_name" {
  description = "Existing firewall rule name to import"
  type        = string
  default     = "default-allow-ssh"  # You can change this if you have a custom rule
}

