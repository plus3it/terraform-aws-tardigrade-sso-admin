output "permission_set" {
  description = "Object of attributes for the AWS SSO Permission Set"
  value       = aws_ssoadmin_permission_set.this

  depends_on = [
    # Force terraform to wait when returning permission_set output, until all policy
    # attachments are complete
    aws_ssoadmin_permission_set_inline_policy.this,
    aws_ssoadmin_managed_policy_attachment.this,
    aws_ssoadmin_customer_managed_policy_attachment.this,
  ]
}
