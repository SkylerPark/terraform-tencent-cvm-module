###################################################
# CVM Instance
###################################################
variable "name" {
  description = "(필수) 인스턴스 이름"
  type        = string
  nullable    = false
}

variable "cam_role_name" {
  description = "(선택) 인스턴스 CAM Role 이름 설정 값."
  type        = string
  default     = null
}

variable "hostname" {
  description = <<EOF
  (선택) 호스트네임 설정 `hostname` 블록 내용".
    (선택) `enabled` - 호스트네임 설정 여부 default: `false`.
    (선택) `name` - 호스트네임 값.
  EOF
  type        = any
  default     = null
}

variable "iamge_id" {
  description = "(선택) 인스턴스 이미지 default: `null`"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "(선택) 인스턴스 타입 default: `S5.MEDIUM2`"
  type        = string
  default     = "S5.MEDIUM2"
}

variable "key_id" {
  description = "(선택) 인스턴스 로 Access 할수 있는 SSH Key ID default: `null`"
  type        = string
  default     = null
}

variable "image_id" {
  description = "(선택) 인스턴스 이미지 ID."
  type        = string
  default     = null
}

variable "system_disk_type" {
  description = "(선택) OS 디스크 타입 Valid values: LOCAL_BASIC: local disk, LOCAL_SSD: local SSD disk, CLOUD_SSD: SSD, CLOUD_PREMIUM: Premium Cloud Storage, CLOUD_BSSD: Basic SSD."
  type        = string
  default     = null
}

variable "system_disk_size" {
  description = "(선택) OS 디스크 사이즈 default: `10`"
  type        = number
  default     = 10
}

variable "project_id" {
  description = "(필수) 인스턴스가 생성될 Project ID, default: `0`."
  type        = number
  default     = 0
  nullable    = false
}

variable "password" {
  description = "(선택) 인스턴스 패스워드, 패스워드로 접속 가능."
  type        = string
  default     = null
}

variable "allocate_public_ip" {
  description = "(선택) 인스턴스 Public IP 할당 여부."
  type        = bool
  default     = false
}

variable "charge_type" {
  description = "(선택) EIP 할당시 요금 지불방법 values `BANDWIDTH_PACKAGE`, `TRAFFIC_POSTPAID_BY_HOUR` default: TRAFFIC_POSTPAID_BY_HOUR"
  type        = string
  default     = "TRAFFIC_POSTPAID_BY_HOUR"
}

variable "bandwidth_max_out" {
  description = "(선택) Public IP 할당시 Bandwidth."
  type        = number
  default     = null
}

variable "vpc_id" {
  description = "(선택) 인스턴스를 할당할 VPC ID."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "(선택) 인스턴스를 시작할 AZ."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(선택) 인스턴스 Subnet ID."
  type        = string
  default     = null
}

variable "security_groups" {
  description = "(선택) 인스턴스 보안그룹 리스트"
  type        = set(string)
  default     = []
}

variable "monitoring_enabled" {
  description = "(선택) 세부 모니터링 활성화."
  type        = bool
  default     = true
}

variable "security_service_enabled" {
  description = "(선택) 세부 보안 서비스 활성화."
  type        = bool
  default     = true
}

variable "api_termination_enabled" {
  description = "(선택) API 로 종료 보호 활성화."
  type        = bool
  default     = true
}

variable "state" {
  description = "(선택) 인스턴스 상태 `RUNNING`, `STOPPED` or `FORCED_STOP` default: `RUNNING`."
  type        = string
  default     = "RUNNING"
  nullable    = false

  validation {
    condition     = contains(["RUNNING", "STOPPED", "FORCED_STOP"], var.state)
    error_message = "다음 입력 값으로 입력. `RUNNING`, `STOPPED` or `FORCED_STOP`."
  }
}

variable "tags" {
  description = "(선택) 리소스 태그 내용"
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "(선택) 인스턴스 태그 내용"
  type        = map(string)
  default     = {}
}

###################################################
# CBS Storage
###################################################
variable "cbs_block_device" {
  description = "(선택) 인스턴스 추가 CBS 블록."
  type        = any
  default     = {}
}

variable "cbs_tags" {
  description = "(선택) CBS 태그 내용"
  type        = map(string)
  default     = {}
}

###################################################
# ElasticIP
###################################################
variable "eip_enabled" {
  description = "(선택) Instance 에 Elastic IP 할당 여부"
  type        = bool
  default     = false
}

variable "eip_tags" {
  description = "(선택) ElasticIP 태그 내용"
  type        = map(string)
  default     = {}
}
