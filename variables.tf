variable "sso_admin" {
  description = "Object of inputs for SSO Admin resources"
  type = object({
    account_assignments = optional(any, [])
    permission_sets     = optional(any, [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for account_assignment in var.sso_admin.account_assignments : try(account_assignment.name, null) != null])
    error_message = "For all account assignments, `name` is required. It is used as a `for_each` iterator, so it must be unique and known at plan-time."
  }

  validation {
    condition     = alltrue([for permission_set in var.sso_admin.permission_sets : try(permission_set.name, null) != null])
    error_message = "For all permission sets, `name` is required. It is used as a `for_each` iterator, so it must be unique and known at plan-time."
  }
}
