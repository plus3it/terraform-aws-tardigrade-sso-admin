# terraform-aws-tardigrade-sso-admin/modules/account-assignment

Module for managing an AWS SSO Account Assignment

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.40.0 |

## Resources

| Name | Type |
|------|------|
| [aws_identitystore_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_group) | data source |
| [aws_identitystore_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_user) | data source |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_permission_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_assignment"></a> [account\_assignment](#input\_account\_assignment) | Object of inputs for managing an AWS SSO Account Assignment | <pre>object({<br>    identity_store_id     = optional(string)<br>    instance_arn          = optional(string)<br>    principal_name        = string<br>    principal_type        = optional(string, "GROUP")<br>    permission_set_arn    = optional(string)<br>    permission_set_name   = optional(string)<br>    organization_accounts = optional(list(string))<br>    target_id             = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_assignment"></a> [account\_assignment](#output\_account\_assignment) | Object of attributes for the AWS SSO Account Assignment |

<!-- END TFDOCS -->
