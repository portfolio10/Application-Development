resource "aws_lambda_function" "sast_lambda" {
  function_name = var.function_name
  role          = var.iam_role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.11"
  timeout       = 30

  filename         = "${path.module}/index.zip"
  source_code_hash = filebase64sha256("${path.module}/index.zip")

  environment {
    variables = {
      SLACK_URL = var.slack_webhook_url
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sast_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.sast_s3_bucket_arn
}

resource "aws_s3_bucket_notification" "sast_notification" {
  bucket = var.sast_s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.sast_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.sast_s3_filter_prefix
  }

  depends_on = [aws_lambda_permission.allow_s3]
}
