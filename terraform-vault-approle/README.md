# Terraform with Vault using Vault approle auth

This prototype illustrates how to configure the Terraform Vault Provider to login to Vault using an approle.

## pre-requisites

* You have a Vault server and your token has the necessary access to:
    * Enable Auth backends and configure them
    * Create policies in Vault
* You have a TFC Organization, Project and Workspace defined. You have access to manage Variables and a Variable Set.

## Prepare your Vault server

Perform these steps on your Vault server.

### Enable the approle Auth Backend

```
vault auth enable approle
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
