module "test_sso_admin" {
  source = "../../"

  sso_admin = {
    account_assignments = [
      {
        name                = "TARDIGRADE_TEST_${local.id}"
        permission_set_name = "TARDIGRADE_TEST_${local.id}"
        principal_name      = var.principal_name
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

locals {
  id         = data.terraform_remote_state.prereq.outputs.id
  account_id = data.aws_caller_identity.this.account_id
}

data "aws_caller_identity" "this" {}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}
