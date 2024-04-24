# We use a AWS Provider data resource as a no-op test of the AWS provider config.

data "aws_iam_openid_connect_provider" "noop" {
  url = "https://app.terraform.io"
}

# Now display the seal status output
output "tfc_client_id_list" {
  value = data.aws_iam_openid_connect_provider.noop.client_id_list
}
