resource "aws_ssoadmin_account_assignment" "platform_admin" {
  for_each = local.all_account_ids

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.platform_admin.arn

  principal_id   = data.aws_identitystore_group.data_admins.group_id
  principal_type = "GROUP"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"
}