module "test_sso_admin" {
  source = "../../"

  sso_admin = {
    account_assignments = [
      {
        name                = "TARDIGRADE_TEST_1_${local.id}"
        permission_set_name = "TARDIGRADE_TEST_${local.id}"
        principal_name      = var.principal_name
        principal_type      = "GROUP"
        target_id           = local.account_id
      },
      {
        name                = "TARDIGRADE_TEST_2_${local.id}"
        permission_set_name = "TARDIGRADE_TEST_${local.id}"
        principal_id        = aws_identitystore_group.test.group_id
        principal_type      = "GROUP"
        target_id           = local.account_id
      },
    ]

    permission_sets = [
      {
        name        = "TARDIGRADE_TEST_${local.id}"
        description = "Test permission set - ${local.id}"
        managed_policy_attachments = [
          {
            policy_name = "ReadOnlyAccess"
          },
        ]
      },
    ]
  }
}

resource "aws_identitystore_group" "test" {
  display_name      = "TARDIGRADE_TEST_${local.id}"
  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]
}

locals {
  id         = data.terraform_remote_state.prereq.outputs.id
  account_id = data.aws_caller_identity.this.account_id
}

data "aws_ssoadmin_instances" "this" {}

data "aws_caller_identity" "this" {}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}
