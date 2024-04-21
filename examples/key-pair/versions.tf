terraform {
  required_version = ">= 0.12"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">1.18.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.4"
    }
  }
}
