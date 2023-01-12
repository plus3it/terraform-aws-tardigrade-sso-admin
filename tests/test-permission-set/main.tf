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
  id = data.terraform_remote_state.prereq.outputs.id
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}
