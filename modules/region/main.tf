resource "stackit_network_area_region" "this" {
  for_each = var.regions

  organization_id = var.organization_id
  network_area_id = var.network_area_id
  region          = each.value.region

  ipv4 = {
    transfer_network      = each.value.ipv4.transfer_network
    network_ranges        = each.value.ipv4.network_ranges
    default_nameservers   = each.value.ipv4.default_nameservers
    default_prefix_length = each.value.ipv4.default_prefix_length
    max_prefix_length     = each.value.ipv4.max_prefix_length
    min_prefix_length     = each.value.ipv4.min_prefix_length
  }
}
