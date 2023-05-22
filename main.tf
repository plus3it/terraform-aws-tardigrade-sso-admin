module "permission_sets" {
  source   = "./modules/permission-set"
  for_each = { for permission_set in var.sso_admin.permission_sets : permission_set.name => permission_set }

  permission_set = merge(
    each.value,
    {
      instance_arn = local.sso_instance_arn
      partition    = local.partition
    },
  )
}

module "account_assignments" {
  source   = "./modules/account-assignment"
  for_each = { for account_assignment in var.sso_admin.account_assignments : account_assignment.name => account_assignment }

  account_assignment = merge(
    each.value,
    {
      identity_store_id = local.identity_store_id
      instance_arn      = local.sso_instance_arn

      permission_set_arn = (
        try(each.value.permission_set_arn, null) != null ||
        contains(
          var.sso_admin.permission_sets[*].name,
          try(each.value.permission_set_name, null)
        )
      ) ? module.permission_sets[each.value.permission_set_name].permission_set.arn : null

      # Null `permission_set_name` if `permission_set_arn` is provided or can
      # be looked up from the permission-set module
      permission_set_name = (
        try(each.value.permission_set_arn, null) != null ||
        contains(
          var.sso_admin.permission_sets[*].name,
          try(each.value.permission_set_name, null)
        )
      ) ? null : each.value.permission_set_name
    },
  )
}

data "aws_ssoadmin_instances" "this" {}
data "aws_partition" "this" {}

locals {
  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]
  sso_instance_arn  = data.aws_ssoadmin_instances.this.arns[0]
  partition         = data.aws_partition.this.partition
}
