resource "aws_iam_role" "fluentbit-role" {
  name = "dev-eks-logging"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "fluentbit-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      "Statement": [
    {
      "Action": [
        "es:ESHttp*"
      ],
      "Resource": "arn:aws:es:${var.aws_region}:${var.account_id}:domain/${var.es_domain}",
      "Effect": "Allow"
    }
  ]
  })
  }
}


