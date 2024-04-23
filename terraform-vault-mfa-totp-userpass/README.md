# terraform-vault-mfa-totp-userpass

This prototype will demonstrate how to use Terraform, to configure Vault, to enable totp MFA for a user in a **userpass** auth method. This code will create the following items in your Vault server.

* A **userpass** auth method mounted at `mfa-proto/userpass`.
* A demo user (you select the name and password) within that userpass mount name.
* A totp config enabled for the above **userpass** auth method.
* MFA via totp enforced on the above **userpass** auth method.

The output of this prototype will then describe the steps you must perform to enable totp MFA on the demo user.

A Vault policy file is included which you can load and apply to your normal Vault user to allow the above resources to be created and configured.

## Pre-requisites

* You have a Vault server and your token has the necessary access to:
    * Enable Auth backends and configure them
    * Create policies in Vault
* You have your Terraform environment set up to have access to your Vault server
* You have an authenticator app which supports totp

## Running the prototype

* Fork/copy/whatever this repo/dir/code to your own VCS
* Configure the values for the variables `auth_userpass_user_id` and `auth_userpass_user_password` in your Terraform config
* Create the necessary policy using the [`vault-policy-mfa-totp-proto.hcl`](./vault-policy-mfa-totp-proto.hcl)
* Plan and Apply the Terraform code
* Review the instructions in the Output. You still need to run the Vault command to produce the totp token for your prototype user.
* Once you have complete the instructions in the Output, sign-in to Vault with your prototype user. You will need to ensure you enter the correct details to ensure you're able to sign in.
    * Method: Username
    * Username: Enter the value you used in the `auth_userpass_user_id` Terraform variable
    * Password: Enter the value you used in the `auth_userpass_user_password` Terraform variable
    * Click the **More options** and enter the **Mount path** as `mfa-proto/userpass`
    * Press the **Sign in** button
* You will be prompted to enter the MFA code for the totp token you created above when you scanned the QR code into your authenticator app.
