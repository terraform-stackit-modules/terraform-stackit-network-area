module "area" {
  source = "./modules/area"

  create_area     = var.create_area
  organization_id = var.organization_id
  name            = var.name
  labels          = var.labels
}

module "region" {
  source = "./modules/region"

  organization_id = var.organization_id
  network_area_id = coalesce(module.area.network_area_id, var.network_area_id)
  regions         = var.regions
}

module "route" {
  source = "./modules/route"

  organization_id = var.organization_id
  network_area_id = coalesce(module.area.network_area_id, var.network_area_id)
  routes          = var.routes

  # A network-area route is scoped to a region and the STACKIT API rejects it
  # (404 "resource not found") if the region does not yet exist. region and
  # route both depend only on module.area, so without this they run in
  # parallel and the route can start before its region is ready. Force the
  # route module to wait for all regions to be created first.
  depends_on = [module.region]
}
