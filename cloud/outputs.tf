output "billing_user_access_key_id" {
  description = "The API access key ID for the bill monitoring user"
  value       = aws_iam_access_key.billing_user_access_key.id
}

output "billing_user_secret_key" {
  description = "The API credentials for the bill monitoring user"
  value       = aws_iam_access_key.billing_user_access_key.encrypted_secret
}
