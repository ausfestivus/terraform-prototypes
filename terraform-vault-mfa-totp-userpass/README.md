# terraform-vault-mfa-totp-userpass

This prototype will demonstrate how to use Terraform, to configure Vault, to enable totp MFA for a user in a **userpass** auth method. This code will create the following items in your Vault server.

* A **userpass** auth method mounted at `mfa-proto/userpass`.
* A demo user (you select the name) within that userpass mount name.
* A totp config enabled for the above **userpass** auth method.
* MFA via totp enforced on the above **userpass** auth method.

The output of this prototype will then describe the steps you must perform to enable totp MFA on the demo user.

A Vault policy file is included which you can load and apply to your normal Vault user to allow the above resources to be created and configured.

## Pre-requisites

* You have a Vault server and your token has the necessary access to:
    * Enable Auth backends and configure them
    * Create policies in Vault

* You have an authenticator app which supports totp

## Running the prototype

* Fork/copy/whatever this repo/dir/code to your own VCS
* Configure the values for the variables `auth_userpass_user_id` and `auth_userpass_user_password` in your Terraform config
*
