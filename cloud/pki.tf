resource "aws_s3_bucket" "pki_bucket" {
  bucket = "pki.${var.domain_name}"
  acl    = "public-read"
  website {
    index_document = "index.html"
  }

  tags = {
    "name"      = "pki-bucket"
    "service"   = "pki"
    "terraform" = "true"
  }
}

resource "aws_route53_record" "pki_record" {
  zone_id = aws_route53_zone.route53_public_zone.zone_id
  name    = "pki.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_s3_bucket.pki_bucket.website_domain
    zone_id                = aws_s3_bucket.pki_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_iam_policy" "pki_policy" {
  name        = "pki"
  description = "Provides full access to the S3 bucket hosting static certificate related content"
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
      "Resource": "${aws_s3_bucket.pki_bucket.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_group" "pki_group" {
  name = "pki"
}

resource "aws_iam_user" "pki_user" {
  name = "pki"
  tags = {
    "name"      = "pki-user"
    "service"   = "pki"
    "terraform" = "true"
  }
}

resource "aws_iam_access_key" "pki_user_access_key" {
  user    = aws_iam_user.billing_user.name
  status  = "Active"
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_user_group_membership" "pki_user_group_membership" {
  user   = aws_iam_user.billing_user.name
  groups = [aws_iam_group.pki_group.name]
}

resource "aws_iam_policy_attachment" "pki_policy_to_pki_group_attachment" {
  name       = "pki_policy_to_pki_group"
  policy_arn = aws_iam_policy.pki_policy.arn
  groups     = [aws_iam_group.pki_group.name]
}
