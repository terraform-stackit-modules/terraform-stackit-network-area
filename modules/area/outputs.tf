output "network_area_id" {
  description = "The network area ID (null when create_area is false)."
  value       = var.create_area ? stackit_network_area.this[0].network_area_id : null
}
