resource "aws_organizations_organization" "this" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "sso.amazonaws.com",
    "cloudtrail.amazonaws.com",
  ]

  enabled_policy_types = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
}

locals {
  root_id = aws_organizations_organization.this.roots[0].id

  accounts = toset(["producers", "platform", "consumers", "shared-services"])
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = "workloads"
  parent_id = local.root_id
}

resource "aws_organizations_account" "this" {
  for_each = local.accounts

  name      = "busdata-${each.key}"
  email     = "${var.email_user}+busdata-${each.key}@${var.email_domain}"
  parent_id = aws_organizations_organizational_unit.workloads.id

  iam_user_access_to_billing = "ALLOW"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [role_name, iam_user_access_to_billing]
  }
}