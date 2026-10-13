output "account_ids" {
  value = { for k, a in aws_organizations_account.this : k => a.id }
}

output "workloads_ou_id" {
  value = aws_organizations_organizational_unit.workloads.id
}