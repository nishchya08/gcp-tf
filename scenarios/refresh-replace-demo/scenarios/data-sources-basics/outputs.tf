output "who_am_i" {
  value       = data.google_client_config.current.project
  description = "Project from active ADC credentials"
}

output "project_number" {
  value       = data.google_project.current.number
  description = "Numeric project ID"
}

output "default_network" {
  value       = data.google_compute_network.default.self_link
  description = "Self link of default VPC"
}

output "debian_image" {
  value       = data.google_compute_image.debian.self_link
  description = "Latest Debian 12 image used for VM"
}

output "instance_name" {
  value       = google_compute_instance.vm.name
  description = "Created VM name"
}

output "uploaded_object" {
  value       = try(google_storage_bucket_object.hello[0].name, null)
  description = "Name of uploaded object (if any)"
}

