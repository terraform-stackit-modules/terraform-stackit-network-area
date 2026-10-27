output "network_area_id" {
  description = "The network area ID created by the example."
  value       = module.network_area.network_area_id
}

output "region_ids" {
  description = "The regional config IDs created by the example."
  value       = module.network_area.region_ids
}

output "route_ids" {
  description = "The route IDs created by the example."
  value       = module.network_area.route_ids
}
