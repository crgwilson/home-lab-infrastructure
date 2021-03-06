output "route53_public_zone_name_servers" {
  description = "The name server list for the created route53 hosted zone"
  value       = aws_route53_zone.route53_public_zone.name_servers
}

output "billing_user_access_key_id" {
  description = "The API access key ID for the bill monitoring user"
  value       = aws_iam_access_key.billing_user_access_key.id
}

output "billing_user_secret_key" {
  description = "The API credentials for the bill monitoring user"
  value       = aws_iam_access_key.billing_user_access_key.encrypted_secret
}

output "s3_info_github_user_access_key_id" {
  description = "The API access key ID providing access to the 'github' directory in the info bucket"
  value       = aws_iam_access_key.s3_info_github_user_access_key.id
}

output "s3_info_github_user_secret_key" {
  description = "The API credentials providing access to the 'github' directory in the info bucket"
  value       = aws_iam_access_key.s3_info_github_user_access_key.encrypted_secret
}
