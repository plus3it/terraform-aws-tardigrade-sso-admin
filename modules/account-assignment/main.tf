resource "aws_ssoadmin_account_assignment" "this" {
  instance_arn       = local.sso_instance_arn
  permission_set_arn = var.account_assignment.permission_set_arn != null ? var.account_assignment.permission_set_arn : data.aws_ssoadmin_permission_set.this[0].arn

  principal_id   = var.account_assignment.principal_type == "GROUP" ? data.aws_identitystore_group.this[0].id : data.aws_identitystore_user.this[0].id
  principal_type = var.account_assignment.principal_type

  target_id   = var.account_assignment.target_id
  target_type = "AWS_ACCOUNT"
}

data "aws_ssoadmin_permission_set" "this" {
  count = var.account_assignment.permission_set_name != null ? 1 : 0

  name         = var.account_assignment.permission_set_name
  instance_arn = local.sso_instance_arn

  depends_on = [
    # When the permission set is managed in the same tfstate, it will not exist
    # during the plan phase until after the first apply. This depends_on forces
    # terraform to wait to evaluate the inputs until after the permission set is
    # created, even on the first apply, ensuring it will exist when this data source
    # is evaluated. See `tests/test-account-assignment` for the setup that will
    # trigger the error condition, if this is removed.
    var.account_assignment
  ]
}

data "aws_identitystore_group" "this" {
  count = var.account_assignment.principal_type == "GROUP" ? 1 : 0

  identity_store_id = local.identity_store_id

  alternate_identifier {
    attribute_name  = "DisplayName"
    attribute_value = var.account_assignment.principal_name
  }
}

data "aws_identitystore_user" "this" {
  count = var.account_assignment.principal_type == "USER" ? 1 : 0

  identity_store_id = local.identity_store_id

  alternate_identifier {
    attribute_name  = "UserName"
    attribute_value = var.account_assignment.principal_name
  }
}

data "aws_ssoadmin_instances" "this" {
  count = var.account_assignment.identity_store_id == null || var.account_assignment.instance_arn == null ? 1 : 0
}

locals {
  # Reduce api calls
  identity_store_id = var.account_assignment.identity_store_id != null ? var.account_assignment.identity_store_id : data.aws_ssoadmin_instances.this[0].identity_store_ids[0]
  sso_instance_arn  = var.account_assignment.instance_arn != null ? var.account_assignment.instance_arn : data.aws_ssoadmin_instances.this[0].arns[0]
}

