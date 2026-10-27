# ─── Core ─────────────────────────────────────────────────────────────────────

variable "organization_id" {
  description = "STACKIT organization ID to which the network area (and its regions/routes) is associated. NOTE: this module is organization-scoped, not project-scoped."
  type        = string
}

# ─── Area ─────────────────────────────────────────────────────────────────────

variable "create_area" {
  description = "Whether to create the network area. Set to false to manage regions/routes against an existing area provided via `network_area_id`."
  type        = bool
  default     = true
}

variable "network_area_id" {
  description = "ID of an existing network area. Used for regions/routes when `create_area` is false."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the network area."
  type        = string
  default     = null
}

variable "labels" {
  description = "Key-value string labels to attach to the network area."
  type        = map(string)
  default     = {}
}

# ─── Regions ──────────────────────────────────────────────────────────────────

variable "regions" {
  description = <<-EOT
    Map of regional IPv4 configs for the network area, keyed by a stable identifier. Each value:
      - `region`               : the region (e.g. "eu01"); defaults to the provider region if null.
      - `ipv4.transfer_network`(required) : IPv4 CIDR transfer network.
      - `ipv4.network_ranges`  (required) : list of `{ prefix = <CIDR> }`.
      - `ipv4.default_nameservers`        : list of DNS servers.
      - `ipv4.default_prefix_length` / `max_prefix_length` / `min_prefix_length` : prefix bounds.
  EOT
  type = map(object({
    region = optional(string)
    ipv4 = object({
      transfer_network = string
      network_ranges = list(object({
        prefix = string
      }))
      default_nameservers   = optional(list(string))
      default_prefix_length = optional(number)
      max_prefix_length     = optional(number)
      min_prefix_length     = optional(number)
    })
  }))
  default = {}
}

# ─── Routes ───────────────────────────────────────────────────────────────────

variable "routes" {
  description = <<-EOT
    Map of static routes for the network area, keyed by a stable identifier. Each value:
      - `region`      : region; defaults to the provider region if null.
      - `destination` (required) : `{ type = "cidrv4", value = "<CIDR>" }` (only cidrv4 supported).
      - `next_hop`    (required) : `{ type = "ipv4"|"blackhole"|"internet", value = "<IP>" }`.
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
}
