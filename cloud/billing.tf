resource "aws_iam_policy" "billing_policy" {
  name        = "billing"
  description = "Provides read only access to costs and cost forecasts"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ce:GetCostAndUsage",
        "ce:GetCostForecast"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group" "billing_group" {
  name = "billing"
}

resource "aws_iam_user" "billing_user" {
  name = "billing"
  tags = {
    "name"      = "billing"
    "service"   = "billing"
    "terraform" = "true"
  }
}

resource "aws_iam_access_key" "billing_user_access_key" {
  user    = aws_iam_user.billing_user.name
  status  = "Active"
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_user_group_membership" "billing_user_group_membership" {
  user   = aws_iam_user.billing_user.name
  groups = [aws_iam_group.billing_group.name]
}

resource "aws_iam_policy_attachment" "billing_policy_to_billing_group_attachment" {
  name       = "billing_policy_to_billing_group"
  policy_arn = aws_iam_policy.billing_policy.arn
  groups     = [aws_iam_group.billing_group.name]
}
