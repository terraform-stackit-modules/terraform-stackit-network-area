resource "stackit_network_area" "this" {
  count = var.create_area ? 1 : 0

  organization_id = var.organization_id
  name            = var.name
  labels          = var.labels
}
