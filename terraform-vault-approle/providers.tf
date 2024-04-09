terraform {
  required_version = "~> 1.5"
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/vault/latest
    vault = {
      source  = "hashicorp/vault"
      version = "=3.20.1"
    }
  }
  # https://www.terraform.io/language/settings/terraform-cloud
  # https://www.terraform.io/cli/cloud/settings
  # https://www.terraform.io/cli/config/environment-variables#tf_workspace
  # Our Cloud backend config is done via Environmental variables
  # https://www.terraform.io/cli/cloud/settings#environment-variables

  # You must run a `source env-vars-???.dev` before running your `terraform` commands.
  # This will setup your shell for the required environment variables.
  cloud {}
}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs
provider "vault" {
  address = var.vault_addr
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }
}
