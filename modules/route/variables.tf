variable "organization_id" {
  description = "STACKIT organization ID to which the network area is associated."
  type        = string
}

variable "network_area_id" {
  description = "The network area ID the routes belong to."
  type        = string
}

variable "routes" {
  description = <<-EOT
    Map of static routes for the network area, keyed by a stable identifier. Each value:
      - `region`      : region; defaults to the provider region if null.
      - `destination` (required) : `{ type = "cidrv4", value = "<CIDR>" }` (only cidrv4 supported).
      - `next_hop`    (required) : `{ type = "ipv4"|"blackhole"|"internet", value = "<IP>" }`
                                   (value only for ipv4; only ipv4 supported currently).
      - `labels`      : key-value labels.
  EOT
  type = map(object({
    region = optional(string)
    destination = object({
      type  = string
      value = string
    })
    next_hop = object({
      type  = string
      value = optional(string)
    })
    labels = optional(map(string))
  }))
  default = {}

  validation {
    condition = alltrue([
      for r in values(var.routes) : contains(["cidrv4", "cidrv6"], r.destination.type)
    ])
    error_message = "routes[*].destination.type must be cidrv4 or cidrv6 (only cidrv4 supported currently)."
  }

  validation {
    condition = alltrue([
      for r in values(var.routes) : contains(["blackhole", "internet", "ipv4", "ipv6"], r.next_hop.type)
    ])
    error_message = "routes[*].next_hop.type must be one of: blackhole, internet, ipv4, ipv6 (only ipv4 supported currently)."
  }
}
