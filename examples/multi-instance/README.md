# multi-instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.13.0 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.18.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.18.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance"></a> [instance](#module\_instance) | ../../modules/instance | n/a |
| <a name="module_public_route_table"></a> [public\_route\_table](#module\_public\_route\_table) | git::https://iep-git.com2us.com/iep/terraform/tencent-vpc-module.git//modules/route-table/ | tags/1.1.1 |
| <a name="module_public_subnet_group"></a> [public\_subnet\_group](#module\_public\_subnet\_group) | git::https://iep-git.com2us.com/iep/terraform/tencent-vpc-module.git//modules/subnet-group/ | tags/1.1.1 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git::https://iep-git.com2us.com/iep/terraform/tencent-vpc-module.git//modules/security-group/ | tags/1.1.1 |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ../../modules/key-pair | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://iep-git.com2us.com/iep/terraform/tencent-vpc-module.git//modules/vpc/ | tags/1.1.1 |

## Resources

| Name | Type |
|------|------|
| [tencentcloud_image.rocky8](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/image) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
