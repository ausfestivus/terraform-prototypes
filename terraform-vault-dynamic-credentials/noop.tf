# We use a Vault Provider data resource as a no-op test of the Vault provider config.

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret
data "vault_generic_secret" "path_value" {
  path = "auth/jwt/config"
}

# Now display the config
output "jwt_auth_config" {
  value = data.vault_generic_secret.path_value
}
