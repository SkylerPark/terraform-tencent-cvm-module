# instance

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

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_cbs_storage.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/cbs_storage) | resource |
| [tencentcloud_cbs_storage_attachment.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/cbs_storage_attachment) | resource |
| [tencentcloud_eip.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/eip) | resource |
| [tencentcloud_eip_association.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/eip_association) | resource |
| [tencentcloud_instance.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/instance) | resource |
| [tencentcloud_instances.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocate_public_ip"></a> [allocate\_public\_ip](#input\_allocate\_public\_ip) | (선택) 인스턴스 Public IP 할당 여부. | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (선택) 인스턴스를 시작할 AZ. | `string` | `null` | no |
| <a name="input_cam_role_name"></a> [cam\_role\_name](#input\_cam\_role\_name) | (선택) 인스턴스 CAM Role 이름 설정 값. | `string` | `null` | no |
| <a name="input_cbs_block_device"></a> [cbs\_block\_device](#input\_cbs\_block\_device) | (선택) 인스턴스 추가 CBS 블록. | `any` | `{}` | no |
| <a name="input_cbs_tags"></a> [cbs\_tags](#input\_cbs\_tags) | (선택) CBS 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_charge_type"></a> [charge\_type](#input\_charge\_type) | (선택) EIP 할당시 요금 지불방법 values `BANDWIDTH_PACKAGE`, `TRAFFIC_POSTPAID_BY_HOUR` default: TRAFFIC\_POSTPAID\_BY\_HOUR | `string` | `"TRAFFIC_POSTPAID_BY_HOUR"` | no |
| <a name="input_eip_enabled"></a> [eip\_enabled](#input\_eip\_enabled) | (선택) Instance 에 Elastic IP 할당 여부 | `bool` | `false` | no |
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | (선택) ElasticIP 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | (선택) 인스턴스 강제 삭제 여부. `true`시 인스턴스가 휴지통으로 이동하지않고 영구 삭제. | `bool` | `false` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | (선택) 호스트네임 설정 `hostname` 블록 내용".<br>    (선택) `enabled` - 호스트네임 설정 여부 default: `false`.<br>    (선택) `name` - 호스트네임 값. | `any` | `null` | no |
| <a name="input_iamge_id"></a> [iamge\_id](#input\_iamge\_id) | (선택) 인스턴스 이미지 default: `null` | `string` | `null` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | (선택) 인스턴스 이미지 ID. | `string` | `null` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | (선택) 인스턴스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (선택) 인스턴스 타입 default: `S5.MEDIUM2` | `string` | `"S5.MEDIUM2"` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | (선택) 인스턴스 로 Access 할수 있는 SSH Key ID default: `null` | `string` | `null` | no |
| <a name="input_max_bandwidth_out"></a> [max\_bandwidth\_out](#input\_max\_bandwidth\_out) | (선택) Public IP 할당시 Bandwidth. | `number` | `null` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | (선택) 세부 모니터링 활성화. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) 인스턴스 이름 | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | (선택) 인스턴스 패스워드, 패스워드로 접속 가능. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (선택) 인스턴스가 생성될 Project ID, default: `0`. | `number` | `0` | no |
| <a name="input_running_flag"></a> [running\_flag](#input\_running\_flag) | (선택) 인스턴스 실행 및 중지 설정 `true` 일 경우 실행 `false` 일 경우 중지 default: true | `bool` | `true` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (선택) 인스턴스 보안그룹 리스트 | `set(string)` | `[]` | no |
| <a name="input_security_service_enabled"></a> [security\_service\_enabled](#input\_security\_service\_enabled) | (선택) 세부 보안 서비스 활성화. | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (선택) 인스턴스 Subnet ID. | `string` | `null` | no |
| <a name="input_system_disk_size"></a> [system\_disk\_size](#input\_system\_disk\_size) | (선택) OS 디스크 사이즈 default: `10` | `number` | `10` | no |
| <a name="input_system_disk_type"></a> [system\_disk\_type](#input\_system\_disk\_type) | (선택) OS 디스크 타입 Valid values: LOCAL\_BASIC: local disk, LOCAL\_SSD: local SSD disk, CLOUD\_SSD: SSD, CLOUD\_PREMIUM: Premium Cloud Storage, CLOUD\_BSSD: Basic SSD. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (선택) 인스턴스를 할당할 VPC ID. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | 인스턴스 Availability Zone |
| <a name="output_cpu"></a> [cpu](#output\_cpu) | 인스턴스 CPU |
| <a name="output_disk"></a> [disk](#output\_disk) | 인스턴스 DISK |
| <a name="output_id"></a> [id](#output\_id) | 인스턴스 UUID |
| <a name="output_memory"></a> [memory](#output\_memory) | 인스턴스 Memory (GiB) |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | 인스턴스 Private IP |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | 인스턴스 Public IP |
| <a name="output_state"></a> [state](#output\_state) | 인스턴스 상태 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
