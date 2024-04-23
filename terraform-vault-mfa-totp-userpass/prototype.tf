#region auth-method
# add our userpass auth method
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend
resource "vault_auth_backend" "prototype_auth_userpass" {
  type = "userpass"
  path = "${local.prototype_name}/userpass"
}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_endpoint
# add and configure a users to the userpass auth method
resource "vault_generic_endpoint" "prototype_auth_userpass_user" {
  depends_on           = [vault_auth_backend.prototype_auth_userpass]
  path                 = "auth/${local.prototype_name}/userpass/users/${var.auth_userpass_user_id}"
  ignore_absent_fields = true

  data_json = jsonencode(local.auth_userpass_user_proto_json)
}
#endregion

#region totp-configs
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_mfa_totp
resource "vault_identity_mfa_totp" "prototype_totp_method" {
  issuer    = local.prototype_name
  algorithm = "SHA256"
  digits    = 6
  qr_size   = 200
  key_size  = 30
  period    = 30
}

#https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_mfa_login_enforcement
resource "vault_identity_mfa_login_enforcement" "prototype_userpass" {
  auth_method_accessors = [vault_auth_backend.prototype_auth_userpass.accessor]
  mfa_method_ids        = [vault_identity_mfa_totp.prototype_totp_method.method_id]
  name                  = local.prototype_name
}
#endregion

#region prototype-user entity and alias
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity
resource "vault_identity_entity" "prototype_user" {
  depends_on = [vault_generic_endpoint.prototype_auth_userpass_user]
  name       = var.auth_userpass_user_id
}
resource "vault_identity_entity_alias" "prototype_user" {
  canonical_id   = vault_identity_entity.prototype_user.id
  mount_accessor = vault_auth_backend.prototype_auth_userpass.accessor
  name           = vault_identity_entity.prototype_user.name
}
#endregion
