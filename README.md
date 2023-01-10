# terraform-aws-tardigrade-sso-admin
Terraform module to manage AWS SSO Admin resources, including:

* [AWS SSO Account Assignments](modules/account-assignments)
* [AWS SSO Permission Sets](modules/permission-sets)

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30 |

## Resources

| Name | Type |
|------|------|
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sso_admin"></a> [sso\_admin](#input\_sso\_admin) | Object of inputs for SSO Admin resources | <pre>object({<br>    account_assignments = optional(any, [])<br>    permission_sets     = optional(any, [])<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_assignments"></a> [account\_assignments](#output\_account\_assignments) | Object of all AWS SSO Account Assignments |
| <a name="output_permission_sets"></a> [permission\_sets](#output\_permission\_sets) | Object of all AWS SSO Permission Sets |

<!-- END TFDOCS -->
