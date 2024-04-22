# Manage identity entities
path "identity/entity" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "identity/entity/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "identity/entity-alias" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "identity/entity-alias/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Manage MFA totp
path "identity/mfa/method/totp" {
  capabilities = ["create", "update"]
}

path "identity/mfa/method/totp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Manage MFA login enforcement
path "identity/mfa/login-enforcement/mfa-proto" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
