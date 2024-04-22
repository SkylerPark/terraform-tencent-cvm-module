# terraform-tencent-cvm-module

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Component

아래 도구를 이용하여 모듈작성을 하였습니다. 링크를 참고하여 OS 에 맞게 설치 합니다.

> **macos** : ./bin/install-macos.sh

- [pre-commit](https://pre-commit.com)
- [terraform](https://terraform.io)
- [tfenv](https://github.com/tfutils/tfenv)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [tfsec](https://github.com/tfsec/tfsec)
- [tflint](https://github.com/terraform-linters/tflint)

## Services

해당 Terraform 모듈을 사용하여 아래 서비스를 관리 합니다.

- **Tencent CVM (Cloud Virtual Machine)**
  - instance
  - key-pair
  - cbs-storage
  - elatic-ip

## Usage

아래 예시를 활용하여 작성가능하며 examples 코드를 참고 부탁드립니다.

### Single CVM Instance

하나의 CVM 인스턴스를 생성 하는 예시 입니다.

```hcl
module "instance" {
  source                     = "../../modules/instance"
  name                       = "parksm-test-01"
  image_id                   = data.tencentcloud_image.rocky8.image_id
  key_id                     = module.ssh_key.name
  system_disk_size           = 50
  system_disk_type           = "CLOUD_PREMIUM"
  eip_enabled                = true
  vpc_id                     = module.vpc.id
  subnet_id                  = module.public_subnet_group.ids[0]
  security_groups            = [module.security_group.id]
  availability_zone          = local.availability_zones[0]
  internet_max_bandwidth_out = 100
  cbs_block_device = {
    swap = {
      storage_size = 10
      storage_type = "CLOUD_PREMIUM"
      encrypt      = true
    }
  }
}
```

### Multiple EC2 Instance

하나 이상의 EC2 Instance 를 생성 하는 예시입니다.

```hcl
locals {
  instances = {
    "01" = {
      subnet            = "subnet-public-01"
      availability_zone = "ap-seoul-1"
    }
    "02" = {
      subnet            = "subnet-public-02"
      availability_zone = "ap-seoul-2"
    }
  }
}

module "instance" {
  source                     = "../../modules/instance"
  for_each                   = local.instances
  name                       = "parksm-test-${each.key}"
  image_id                   = data.tencentcloud_image.rocky8.image_id
  key_id                     = module.ssh_key.name
  system_disk_size           = 50
  system_disk_type           = "CLOUD_PREMIUM"
  eip_enabled                = true
  vpc_id                     = module.vpc.id
  availability_zone          = each.value.availability_zone
  subnet_id                  = each.value.subnet
  security_groups            = [module.security_group.id]
  internet_max_bandwidth_out = 100
  cbs_block_device = {
    swap = {
      storage_size = 10
      storage_type = "CLOUD_PREMIUM"
      encrypt      = true
    }
  }
}

```
