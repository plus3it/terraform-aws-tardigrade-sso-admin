output "permission_sets" {
  description = "Object of all AWS SSO Permission Sets"
  value       = module.permission_sets
}

output "account_assignments" {
  description = "Object of all AWS SSO Account Assignments"
  value       = module.account_assignments
}
