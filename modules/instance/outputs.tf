data "tencentcloud_instances" "this" {
  instance_id = tencentcloud_instance.this.id
}

output "id" {
  description = "인스턴스 UUID"
  value       = tencentcloud_instance.this.id
}

output "state" {
  description = "인스턴스 상태"
  value       = tencentcloud_instance.this.running_flag ? "running" : "stopped"
}

output "private_ip" {
  description = "인스턴스 Private IP"
  value       = tencentcloud_instance.this.private_ip
}

output "public_ip" {
  description = "인스턴스 Public IP"
  value       = var.eip_enabled ? tencentcloud_eip.this[0].public_ip : tencentcloud_instance.this.public_ip
}

output "availability_zone" {
  description = "인스턴스 Availability Zone"
  value       = tencentcloud_instance.this.availability_zone
}

output "disk" {
  description = "인스턴스 DISK"
  value = concat(
    ["vHDD / ${var.system_disk_size}"], [
      for k, disk in var.cbs_block_device :
      "vHDD / ${disk.storage_size}"
    ]
  )
}

output "cpu" {
  description = "인스턴스 CPU"
  value       = data.tencentcloud_instances.this.instance_list[0].cpu
}

output "memory" {
  description = "인스턴스 Memory (GiB)"
  value       = data.tencentcloud_instances.this.instance_list[0].memory
}
