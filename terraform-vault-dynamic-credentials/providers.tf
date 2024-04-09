terraform {
  required_version = "~> 1.7"
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/vault/latest
    vault = {
      source  = "hashicorp/vault"
      version = "=3.25"
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
  # With Dynamic Credentials, the Vault Provider inherits configuration information from the Terraform run environment.
  # https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/vault-configuration#vault-provider-configuration
}
