# Terraform with AWS using Dynamic Credentials

This prototype illustrates how to configure Dynamic Credentials between a Terraform Cloud (TFC) Organization and an AWS Account. This prototype implements the configuration as described at [https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials).

What follows is a TL;DR for the above guide.

## Pre-requisites

* You have an AWS account and sufficient access to configure it's IAM services.
* You have a TFC Organization, Project and Workspace defined. You have access to manage Variables and a Variable Set.

## Prepare your AWS account

Hashicorp provide a page at [https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration) which describes the steps you need to perform in AWS IAM to prepare for the integration.

The AWS configuration detail in the Hashicorp page isn't great. Hashicorp have sample Terraform code [here](https://github.com/hashicorp/terraform-dynamic-credentials-setup-examples/tree/main/aws) that helps a little. Below is some more detail that may help as well.

This example was created using AWS CloudShell.

### Create OIDC provider in IAM

```shell
aws iam create-open-id-connect-provider \
  --url https://app.terraform.io \
  --client-id-list aws.workload.identity
```

This will return a small piece of JSON with the ARN for the OIDC provider. Save this string for later use.

### Create the Trust Policy for the IAM Role for Terraform Cloud

Before you run the following command, you will need to write the Trust Policy definition to a file. Create the json file in your favorite editor in AWS CloudShell and paste the following snippit into it.

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Federated": "FEDERATED_OIDC_ARN_HERE"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringEquals": {
					"app.terraform.io:aud": "aws.workload.identity",
					"app.terraform.io:sub": "organization:YOUR_TFC_ORG_NAME_HERE:project:YOUR_TFC_PROJECT_NAME_HERE:workspace:YOUR_TFC_WORKSPACE_NAME_HERE:run_phase:*"
				}
			}
		}
	]
}
```

Be sure to add the correct values for your environment by replacing the `FEDERATED_OIDC_ARN_HERE`, `YOUR_TFC_ORG_NAME_HERE`, `YOUR_TFC_PROJECT_NAME_HERE`, `YOUR_TFC_WORKSPACE_NAME_HERE` strings in the above sample.

Then run the following command to create the Role in IAM.

```shell
aws iam create-role \
  --role-name YOUR_ROLE_NAME_HERE \
  --description 'AWS IAM Role for access from Terraform Cloud for the YOUR_TFC_ORG_NAME_HERE Organization.' \
  --max-session-duration 3600 \
  --assume-role-policy-document file://PATH_TO_JSON_FILE
```

Again, use your own values for `YOUR_ROLE_NAME_HERE` and `PATH_TO_JSON_FILE`.

### Attach the Permission Policy to the Role

In this step, we will attach the IAM Policy to the Role. You will need the values for your Role Name and the ARN for Permission Policy you want to attach to the Role.

```shell
aws iam attach-role-policy \
  --policy-arn 'PERMISSION_POLICY_ARN_HERE' \
  --role-name 'YOUR_ROLE_NAME_HERE'
```

And with that, you're done. Your AWS Account's IAM service is configured for use with Terraform Cloud Dynamic Credentials. Next, we will configure TFC.

## Prepare your TFC Organization

### Create the Workspace variables

To tell a TFC Workspace to use Dynamic AWS credentials, you must create two Workspace Variables. The following table describes the attributes used in this prototype.


| Variable Name           | Type        | Value                                 |
| ------------------------| ----------- | ------------------------------------- |
| `TFC_AWS_PROVIDER_AUTH` | Environment | `true`                                |
| `TFC_AWS_RUN_ROLE_ARN`  | Environment | The ARN of the role to assume in AWS. |
| `AWS_REGION`            | Environment | The AWS region name you are using.    |


One trick that is useful and will save you time is to create the Variables as part of a Variable Set and then apply that Variable Set to the Workspaces that need to auth to Vault using Dynamic Credentials.

### Example Vault Provider code

See the [`providers.tf`](./providers.tf) file for an example of how to configure the AWS Provider to use Dynamic AWS Credentials.
