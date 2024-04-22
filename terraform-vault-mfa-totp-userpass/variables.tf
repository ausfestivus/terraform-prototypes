variable "proto_user" {
  description = "The name of the the user that will be added to the prototype userpass auth method."
  type        = string
}

variable "auth_userpass_user_roles" {
  description = "A list of the Vault roles to apply to the prototype user."
  default     = ["default", "totp-proto"]
  type        = list(string)
}

variable "auth_userpass_user_password" {
  description = "The password you want to use on your prototype user."
  type        = string
  sensitive   = true
}
