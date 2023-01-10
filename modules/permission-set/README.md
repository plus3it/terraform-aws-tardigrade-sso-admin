# terraform-aws-tardigrade-sso-admin/modules/permission-set

Module for managing an AWS SSO Permission Set

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
| <a name="input_permission_set"></a> [permission\_set](#input\_permission\_set) | Object of inputs for managing an AWS SSO Permission Set | <pre>object({<br>    name             = string<br>    description      = optional(string)<br>    inline_policy    = optional(string)<br>    instance_arn     = optional(string)<br>    relay_state      = optional(string)<br>    partition        = optional(string)<br>    session_duration = optional(string, "PT1H")<br>    tags             = optional(map(string))<br>    managed_policy_attachments = optional(list(object({<br>      policy_name = string<br>      policy_path = optional(string, "/")<br>      policy_type = optional(string, "AWS")<br>    })), [])<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_permission_set"></a> [permission\_set](#output\_permission\_set) | Object of attributes for the AWS SSO Permission Set |

<!-- END TFDOCS -->
