output "instructions" {
  value = "Run the following command to generate the totp token for your user."
}
output "mfa_token_output_prototype" {
  value = "vault write identity/mfa/method/totp/admin-generate method_id=${vault_identity_mfa_totp.prototype_totp_method.method_id} entity_id=${vault_identity_entity.prototype_user.id}"
}

output "then00" {
  value = "Enter the totp URL into the website at https://www.qr-code-generator.com/solutions/image-gallery-qr-code/ to generate the QR code. Save the QR code to disk and open it."
}

output "then01" {
  value = "Use your favorite authenticator app that supports totp to read the QR code."
}
