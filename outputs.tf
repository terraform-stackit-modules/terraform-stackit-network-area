output "network_area_id" {
  description = "The network area ID (created, or the provided network_area_id when create_area is false)."
  value       = coalesce(module.area.network_area_id, var.network_area_id)
}

output "region_ids" {
  description = "Map of region key to the network_area_region resource ID."
  value       = module.region.region_ids
}

output "route_ids" {
  description = "Map of route key to network_area_route ID."
  value       = module.route.route_ids
}
