module "test_account_assignment" {
  source = "../../modules/account-assignment"

  account_assignment = {
    principal_name      = var.principal_name
    principal_type      = "GROUP"
    permission_set_name = module.test_permission_set.permission_set.name
    target_id           = local.account_id
  }
}

module "test_permission_set" {
  source = "../../modules/permission-set"

  permission_set = {
    name        = "TARDIGRADE_TEST_${local.id}"
    description = "Test permission set - ${local.id}"
    managed_policy_attachments = [
      {
        policy_name = "ReadOnlyAccess"
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
