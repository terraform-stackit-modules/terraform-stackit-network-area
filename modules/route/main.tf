resource "stackit_network_area_route" "this" {
  for_each = var.routes

  organization_id = var.organization_id
  network_area_id = var.network_area_id
  region          = each.value.region
  labels          = each.value.labels

  destination = {
    type  = each.value.destination.type
    value = each.value.destination.value
  }

  next_hop = {
    type  = each.value.next_hop.type
    value = each.value.next_hop.value
  }
}
