# We use a Vault Provider data resource as a no-op test of the Vault provider config.

data "vault_generic_secret" "health" {
  path = "/sys/health"
}

# Now display the config
output "sys_health" {
  value = data.vault_generic_secret.health
}
