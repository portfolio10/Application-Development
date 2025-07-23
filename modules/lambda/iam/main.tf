resource "aws_iam_role" "lambda_role" {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "custom_policy" {
  name   = "${var.name}-custom-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject"
        ],
        Resource = "${var.s3_bucket_arn}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "securityhub:BatchImportFindings"
        ],
        Resource = "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "logs:*"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "custom_policy_attach" {
  name       = "${var.name}-custom-attach"
  policy_arn = aws_iam_policy.custom_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}
