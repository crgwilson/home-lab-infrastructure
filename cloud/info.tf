resource "aws_s3_bucket" "info_bucket" {
  bucket = "info.${var.domain_name}"
  acl    = "public-read"
  website {
    index_document = "index.html"
  }

  tags = {
    "name"      = "info-bucket"
    "service"   = "info"
    "terraform" = "true"
  }
}

resource "aws_s3_bucket_policy" "info_bucket_policy" {
  bucket = aws_s3_bucket.info_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InfoBucketPublicReadPolicy",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.info_bucket.arn}/*",
        "${aws_s3_bucket.info_bucket.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "info_github_directory" {
  bucket       = aws_s3_bucket.info_bucket.id
  key          = "github/"
  acl          = "public-read"
  content      = ""
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_object" "info_github_profile_details" {
  bucket  = aws_s3_bucket.info_bucket.id
  key     = "github/0-profile-details.svg"
  acl     = "public-read"
  content = ""
  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "aws_s3_bucket_object" "info_github_repos_per_language" {
  bucket  = aws_s3_bucket.info_bucket.id
  key     = "github/1-repos-per-language.svg"
  acl     = "public-read"
  content = ""
  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "aws_s3_bucket_object" "info_github_most_commit_language" {
  bucket  = aws_s3_bucket.info_bucket.id
  key     = "github/2-most-commit-language.svg"
  acl     = "public-read"
  content = ""
  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "aws_s3_bucket_object" "info_github_stats" {
  bucket  = aws_s3_bucket.info_bucket.id
  key     = "github/3-stats.svg"
  acl     = "public-read"
  content = ""
  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "aws_route53_record" "info_record" {
  zone_id = aws_route53_zone.route53_public_zone.zone_id
  name    = "info.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_s3_bucket.info_bucket.website_domain
    zone_id                = aws_s3_bucket.info_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_iam_policy" "s3_info_github_policy" {
  name        = "s3_info_github"
  description = "Provides access to the github folder in the info S3 bucket"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.info_bucket.arn}/github/*"
    }
  ]
}
EOF
}

resource "aws_iam_group" "s3_info_github_group" {
  name = "s3_info_github"
}

resource "aws_iam_user" "s3_info_github_user" {
  name = "s3_info_github"
  tags = {
    "name"      = "s3_info_github_user"
    "service"   = "info"
    "terraform" = "true"
  }
}

resource "aws_iam_access_key" "s3_info_github_user_access_key" {
  user    = aws_iam_user.s3_info_github_user.name
  status  = "Active"
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_user_group_membership" "s3_info_github_user_group_membership" {
  user   = aws_iam_user.s3_info_github_user.name
  groups = [aws_iam_group.s3_info_github_group.name]
}

resource "aws_iam_policy_attachment" "s3_info_github_policy_to_group_attachment" {
  name       = "s3_info_github_policy_to_group"
  policy_arn = aws_iam_policy.s3_info_github_policy.arn
  groups     = [aws_iam_group.s3_info_github_group.name]
}
