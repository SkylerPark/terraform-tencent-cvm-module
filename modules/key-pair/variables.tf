variable "name" {
  description = "(필수) SSH key pair 이름."
  type        = string
  nullable    = false
}

variable "public_key" {
  description = "(선택) 공개키 내용."
  type        = string
  default     = ""
}

variable "create_private_key" {
  description = "(선택) private key 생성 여부."
  type        = bool
  default     = false
}

variable "private_key_algorithm" {
  description = "(선택) private key 생성시 알고리즘. 지원하는 값 `RSA` and `ED25519` default: `RSA`"
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  description = "(선택) 알고리즘이 `RSA` 일때, RSA key bits 사이즈 default: `4096`"
  type        = number
  default     = 4096
}

variable "tags" {
  description = "(선택) 리소스 태그 내용"
  type        = map(string)
  default     = {}
}
