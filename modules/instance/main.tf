###################################################
# CVM Instance
###################################################
locals {
  state = {
    "RUNNING" = {
      force_delete = false
      running_flag = true
    }
    "STOPPED" = {
      force_delete = false
      running_flag = false
    }
    "FORCED_STOP" = {
      force_delete = true
      running_flag = false
    }
  }
}

resource "tencentcloud_instance" "this" {
  instance_name = var.name
  hostname      = try(var.hostname.enabled, false) ? try(var.hostname.name, var.name) : null
  image_id      = var.image_id
  instance_type = var.instance_type
  key_ids       = var.key_id != null ? [var.key_id] : null
  cam_role_name = var.cam_role_name

  # Storage
  system_disk_type = var.system_disk_type
  system_disk_size = var.system_disk_size

  project_id = var.project_id
  password   = var.password

  # Network
  allocate_public_ip         = var.allocate_public_ip
  internet_max_bandwidth_out = var.eip_enabled ? null : var.bandwidth_max_out
  vpc_id                     = var.vpc_id
  subnet_id                  = var.subnet_id
  orderly_security_groups    = var.security_groups
  availability_zone          = var.availability_zone

  # Attributes
  disable_monitor_service  = !var.monitoring_enabled
  disable_security_service = !var.security_service_enabled
  disable_api_termination  = !var.api_termination_enabled

  force_delete = local.state[var.state].force_delete
  running_flag = local.state[var.state].running_flag

  tags = merge(var.tags, var.instance_tags)

  lifecycle {
    ignore_changes = [image_id]
  }
}

###################################################
# CBS Storage
###################################################
resource "tencentcloud_cbs_storage" "this" {
  for_each          = var.cbs_block_device
  availability_zone = var.availability_zone
  storage_name      = "${var.name}-${each.key}"
  storage_size      = try(each.value.storage_size, 10)
  storage_type      = try(each.value.storage_type, "CLOUD_PREMIUM")
  force_delete      = try(each.value.force_delete, false)
  snapshot_id       = try(each.value.storage_snapshot_id, null)
  encrypt           = try(each.value.encrypt, false)

  tags = merge(var.tags, var.cbs_tags)
}

resource "tencentcloud_cbs_storage_attachment" "this" {
  for_each    = var.cbs_block_device
  instance_id = tencentcloud_instance.this.id
  storage_id  = tencentcloud_cbs_storage.this[each.key].id
}

###################################################
# ElasticIP
###################################################
resource "tencentcloud_eip" "this" {
  count                      = var.eip_enabled ? 1 : 0
  name                       = var.name
  internet_charge_type       = var.charge_type
  internet_max_bandwidth_out = var.bandwidth_max_out
  type                       = "EIP"

  tags = merge(var.tags, var.eip_tags)
}

resource "tencentcloud_eip_association" "this" {
  count       = var.eip_enabled ? 1 : 0
  eip_id      = tencentcloud_eip.this[count.index].id
  instance_id = tencentcloud_instance.this.id
}
