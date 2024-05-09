locals {
  region              = "ap-seoul"
  public_subnet_count = 2
  availability_zones  = ["ap-seoul-1", "ap-seoul-2"]
  vpc_cidr            = "10.70.0.0/16"
}

data "tencentcloud_image" "centos7" {
  image_type = ["PUBLIC_IMAGE"]
  os_name    = "centos 7.5"
}

module "vpc" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/vpc/?ref=tags/1.2.0"
  name   = "parksm-test-vpc"
  ipv4_cidrs = [
    {
      cidr = local.vpc_cidr
    }
  ]
}

module "public_subnet_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/subnet-group/?ref=tags/1.2.0"
  vpc_id = module.vpc.id
  subnets = {
    for idx in range(local.public_subnet_count) : format("parksm-test-public-subnet-0%s", (idx + 1)) => {
      availability_zone = local.availability_zones[idx % length(local.availability_zones)]
      ipv4_cidr         = cidrsubnet(local.vpc_cidr, 8, 10 + idx + 1)
    }
  }
}

module "public_route_table" {
  source  = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/route-table/?ref=tags/1.2.0"
  name    = "parksm-test-public-rt"
  vpc_id  = module.vpc.id
  subnets = module.public_subnet_group.ids

  ipv4_routes = []
}

module "security_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/?ref=tags/1.2.0"
  name   = "parksm-test-sg"
  ingress_rules = [
    {
      action     = "ACCEPT"
      port       = "80,443"
      protocol   = "TCP"
      ipv4_cidrs = ["192.168.0.0/16", "10.0.0.0/8", "172.168.0.0/24"]
    }
  ]

  egress_rules = [
    {
      action     = "ACCEPT"
      port       = "ALL"
      protocol   = "ALL"
      ipv4_cidrs = ["0.0.0.0/0"]
    }
  ]
}

module "ssh_key" {
  source             = "../../modules/key-pair"
  name               = "parksmKey"
  create_private_key = true
}

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
