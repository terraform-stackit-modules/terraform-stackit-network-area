#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module.
#
# This example requires an `organization_id` (network areas are ORGANIZATION-scoped,
# not project-scoped, unlike the other modules). It creates a network area, one
# regional IPv4 config, and one static route.
#####################################################################################

module "network_area" {
  source = "../.."

  organization_id = var.organization_id
  name            = "example-network-area-terratest"

  regions = {
    eu01 = {
      region = "eu01"
      ipv4 = {
        transfer_network = "192.168.1.0/24"
        network_ranges = [
          { prefix = "192.168.0.0/25" },
        ]
        default_nameservers   = ["8.8.8.8"]
        default_prefix_length = 25
        max_prefix_length     = 29
        min_prefix_length     = 24
      }
    }
  }

  routes = {
    internal = {
      region = "eu01"
      destination = {
        type  = "cidrv4"
        value = "10.0.0.0/24"
      }
      next_hop = {
        type  = "ipv4"
        value = "192.168.0.1"
      }
    }
  }

  labels = {
    managed_by = "terraform"
    example    = "basic"
  }
}
