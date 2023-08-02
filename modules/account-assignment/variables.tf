variable "account_assignment" {
  description = "Object of inputs for managing an AWS SSO Account Assignment"
  nullable    = false

  type = object({
    identity_store_id     = optional(string)
    instance_arn          = optional(string)
    principal_name        = string
    principal_type        = optional(string, "GROUP")
    permission_set_arn    = optional(string)
    permission_set_name   = optional(string)
    organization_accounts = optional(list(string))
    target_id             = string
  })

  validation {
    condition     = contains(["GROUP", "USER"], var.account_assignment.principal_type)
    error_message = "The value for `principal_type` must be one of: \"GROUP\", \"USER\"."
  }

  validation {
    condition = anytrue([
      var.account_assignment.permission_set_arn != null,
      var.account_assignment.permission_set_name != null,
    ])
    error_message = "Must set at least one of `permission_set_arn` or `permission_set_name` to a non-null value."
  }
}
