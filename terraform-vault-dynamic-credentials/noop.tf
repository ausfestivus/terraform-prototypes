# We use a Vault Provider data resource as a no-op test of the Vault provider config.

data "vault_auth_backends" "noop" {}

# Now display the config
output "auth_backend_list" {
  value = data.vault_auth_backends.noop.type
}
