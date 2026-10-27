output "route_ids" {
  description = "Map of route key to network_area_route ID."
  value       = { for k, r in stackit_network_area_route.this : k => r.network_area_route_id }
}
