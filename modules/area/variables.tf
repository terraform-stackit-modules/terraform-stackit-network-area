variable "organization_id" {
  description = "STACKIT organization ID to which the network area is associated."
  type        = string
}

variable "create_area" {
  description = "Whether to create the network area."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the network area."
  type        = string
}

variable "labels" {
  description = "Key-value string labels to attach to the network area."
  type        = map(string)
  default     = {}
}
