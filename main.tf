module "permission_sets" {
  source   = "./modules/permission-set"
  for_each = { for permission_set in var.sso_admin.permission_sets : permission_set.name => permission_set }

  permission_set = merge(
    {
      instance_arn = local.sso_instance_arn
      partition    = local.partition
    },
    each.value
  )
}

module "account_assignments" {
  source   = "./modules/account-assignment"
  for_each = { for account_assignment in var.sso_admin.account_assignments : account_assignment.name => account_assignment }

  account_assignment = merge(
    {
      identity_store_id = local.identity_store_id
      instance_arn      = local.sso_instance_arn
      permission_set_arn = try(
        module.permission_sets[each.value.permission_set_name].permission_set.arn,
        null,
      )
    },
    each.value
  )
}

data "aws_ssoadmin_instances" "this" {}
data "aws_partition" "this" {}

locals {
  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]
  sso_instance_arn  = data.aws_ssoadmin_instances.this.arns[0]
  partition         = data.aws_partition.this.partition
}
