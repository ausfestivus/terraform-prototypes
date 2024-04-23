locals {
  # Define a local variable for the path we are mounting the userpass auth method on
  # If you customise this then you will also need to update the policy definition in `vault-policy-mfa-totp-proto.hcl`
  prototype_name = "mfa-proto"
  auth_userpass_user_proto_json = {
    "policies" = var.auth_userpass_user_roles
    "password" = var.auth_userpass_user_password
  }
}
