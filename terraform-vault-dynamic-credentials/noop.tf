# We use a Vault Provider data resource as a no-op test of the Vault provider config.

data "vault_generic_secret" "seal_status" {
  path = "/sys/seal-status"
}

# Now display the seal status output
output "sys_health" {
  value = data.vault_generic_secret.seal_status
}
