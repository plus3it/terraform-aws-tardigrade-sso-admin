variable "permission_set" {
  description = "Object of inputs for managing an AWS SSO Permission Set"
  nullable    = false

  type = object({
    name             = string
    description      = optional(string)
    inline_policy    = optional(string)
    instance_arn     = optional(string)
    relay_state      = optional(string)
    partition        = optional(string)
    session_duration = optional(string, "PT1H")
    tags             = optional(map(string))
    managed_policy_attachments = optional(list(object({
      policy_name = string
      policy_path = optional(string, "/")
      policy_type = optional(string, "AWS")
    })), [])
  })

  validation {
    condition = alltrue([for attachment in var.permission_set.managed_policy_attachments :
      contains(["AWS", "CUSTOMER"], attachment.policy_type)
    ])
    error_message = "For each managed policy attachment, `policy_type` must be one of: \"AWS\", \"CUSTOMER\"."
  }

  validation {
    condition     = length(var.permission_set.managed_policy_attachments) <= 20
    error_message = "Number of managed policies exceeds max limit of 20."
  }

  validation {
    condition = (
      var.permission_set.inline_policy != null ?
      length(jsonencode(jsondecode(var.permission_set.inline_policy))) <= 10240 :
      true
    )
    error_message = "Length of inline policy exceeds max limit of 10,240 characters."
  }
}
