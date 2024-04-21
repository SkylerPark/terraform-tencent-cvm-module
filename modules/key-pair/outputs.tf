output "id" {
  description = "key pair ID"
  value       = tencentcloud_key_pair.this.id
}

output "name" {
  description = "key pair name"
  value       = tencentcloud_key_pair.this.key_name
}

output "public_key" {
  description = "key pair public key"
  value       = tencentcloud_key_pair.this.public_key
}

output "private_key_pem" {
  description = "Private key data PEM (RFC 1421)"
  value       = tls_private_key.this[0].private_key_pem
  sensitive   = true
}
