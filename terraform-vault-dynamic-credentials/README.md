# Terraform with Vault using Dynamic Credentials

This prototype illustrates how to configure Dynamic Credentials between a TFC Organization and a Vault server. This prototype implements the configuration as described at [https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials).

What follows is a TL;DR for the above guide.

Hashicorp have code examples available [here](https://github.com/hashicorp/terraform-dynamic-credentials-setup-examples) as well.

## Pre-requisites

* You have a Vault server and your token has the necessary access to:
    * Enable Auth backends and configure them
    * Create policies in Vault
* You have a TFC Organization, Project and Workspace defined. You have access to manage Variables and a Variable Set.

## Prepare your Vault server

Perform these steps on your Vault server.

### Enable the JWT Auth Backend

```
vault auth enable jwt
```

### Configure the JWT Auth backend to trust TFC

```
vault write auth/jwt/config \
    oidc_discovery_url="https://app.terraform.io" \
    bound_issuer="https://app.terraform.io"
```

### Create the Vault policy that will apply to access from TFC

```
vault policy write tfc-policy vault-policy-tfc-dynamic-creds.hcl
```

### Customise the Vault role definition

Open the [vault-jwt-auth-role.json](./vault-jwt-auth-role.json) file in your favorite editor.
Line 10 in the file says `"sub": "organization:<YOUR TFC ORG NAME HERE>:project:*:workspace:*:run_phase:*"`.
Place your TFC Organization name in the text where it says `<YOUR TFC ORG NAME HERE>`. If your Organization name is **FredNerksOrg**, then you want the string to look like this `"sub": "organization:FredNerksOrg:project:*:workspace:*:run_phase:*"`.

If you are feeling game, you can also further scope the role to the required projects, workspace and run_phase by replacing the `*` with the names of the TFC objects you would like to scope to.

Save and close the json file.

### Create the Vault role that will be used by TFC

```
vault write auth/jwt/role/tfc-role @vault-jwt-auth-role.json
```

## Prepare your TFC Organization

### Create the Workspace variables

To tell a TFC Workspace to use Dynamic Vault credentials, you must create several Workspace Variables. The following table describes the attributes used in this prototype.


| Variable Name             | Type        | Value                                                                                     |
| ------------------------- | ----------- | ----------------------------------------------------------------------------------------- |
| `TFC_VAULT_PROVIDER_AUTH` | Environment | `true`                                                                                    |
| `TFC_VAULT_ADDR`          | Environment | The address of the Vault instance to authenticate against. eg `https://vault.contoso.com` |
| `TFC_VAULT_RUN_ROLE`      | Environment | The name of the Vault role to authenticate against (`tfc-role`, in this prototype)        |

One trick that is useful and will save you time is to create the Variables as part of a Variable Set and then apply that Variable Set to the Workspaces that need to auth to Vault using Dynamic Credentials.

### Example Vault Provider code

See the [`providers.tf`](./providers.tf) file for an example of how to configure the Vault Provider to use Dynamic Vault Credentials.
