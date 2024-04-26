# terraform-prototypes

This repo contains prototype code for using Terraform.

The following prototypes are available:

* [Terraform Cloud with Vault](./terraform-vault-dynamic-credentials/README.md) using [Dynamic Provider Credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials)
* [Terraform Cloud with AWS](./terraform-aws-dynamic-credentials/README.md) using [Dynamic Provider Credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration)
* [Vault totp token with userpass auth method](./terraform-vault-mfa-totp-userpass/README.md)

The following prototypes are planned:

* Terraform Cloud with Azure using Dynamic Provider Credentials
* Terraform Cloud with Vault using Vault approle auth
* Terraform Cloud with Vault using the Azure Secrets Engine to issue Azure AD App Registrations
