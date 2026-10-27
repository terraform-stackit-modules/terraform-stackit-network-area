output "region_ids" {
  description = "Map of region key to the network_area_region resource ID."
  value       = { for k, r in stackit_network_area_region.this : k => r.id }
}
