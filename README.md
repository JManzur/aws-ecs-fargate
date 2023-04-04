## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | [OPTIONAL] List of capacity providers to use for the cluster. | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | [OPTIONAL] Enable container insights for the cluster. | `bool` | `true` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | [REQUIRED] Used to name and tag resources. | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | [OPTIONAL] Used to name and tag global resources. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_identifiers"></a> [ecs\_cluster\_identifiers](#output\_ecs\_cluster\_identifiers) | Attributes that identify the cluster |
