resource "aws_ssoadmin_permission_set" "this" {
  name             = var.permission_set.name
  description      = var.permission_set.description
  instance_arn     = local.sso_instance_arn
  relay_state      = var.permission_set.relay_state
  session_duration = var.permission_set.session_duration
  tags             = var.permission_set.tags
}

resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  count = var.permission_set.inline_policy != null ? 1 : 0

  inline_policy      = var.permission_set.inline_policy
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = { for attachment in var.permission_set.managed_policy_attachments : "${var.permission_set.name}:${attachment.policy_name}" => attachment if attachment.policy_type == "AWS" }

  instance_arn       = local.sso_instance_arn
  managed_policy_arn = replace("arn:${local.partition}:iam::aws:policy/${each.value.policy_path}/${each.value.policy_name}", "/[/]+/", "/")
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "this" {
  for_each = { for attachment in var.permission_set.managed_policy_attachments : "${var.permission_set.name}:${attachment.policy_name}" => attachment if attachment.policy_type == "CUSTOMER" }

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  customer_managed_policy_reference {
    name = each.value.policy_name
    path = each.value.policy_path
  }
}

data "aws_partition" "this" {
  count = var.permission_set.partition == null ? 1 : 0
}

data "aws_ssoadmin_instances" "this" {
  count = var.permission_set.instance_arn == null ? 1 : 0
}

locals {
  # Reduce api calls
  sso_instance_arn = var.permission_set.instance_arn != null ? var.permission_set.instance_arn : data.aws_ssoadmin_instances.this[0].arns[0]
  partition        = var.permission_set.partition != null ? var.permission_set.partition : data.aws_partition.this[0].partition
}
