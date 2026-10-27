variable "organization_id" {
  description = "STACKIT organization ID to which the network area is associated."
  type        = string
}

variable "network_area_id" {
  description = "The network area ID the regional configs belong to."
  type        = string
}

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
