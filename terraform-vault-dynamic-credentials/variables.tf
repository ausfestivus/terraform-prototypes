variable "login_approle_role_id" {
  type        = string
  description = "Approle role_id used for token to do Vault config of our path."
}

variable "login_approle_secret_id" {
  type        = string
  sensitive   = true
  description = "Approle secret_id used for token to do Vault config of our path."
}

variable "vault_addr" {
  type        = string
  description = "https URL for your Vault server."
}
