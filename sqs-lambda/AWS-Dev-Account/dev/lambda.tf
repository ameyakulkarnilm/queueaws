resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.iam_role_for_lambda_name}-${var.env}-env"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "../lambda-deploy-zip"
    output_path = "lambda-deploy.zip"
}
resource "aws_lambda_function" "lambda_function" {
  filename                       = "../lambda-deploy-zip/lambda-deploy.zip"
  function_name                  = "${var.lambda_function_name}-${var.env}-env"
  role                           = "${aws_iam_role.iam_for_lambda.arn}"
  handler                        = "${var.lambda_handler_name}"
  source_code_hash               = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime                        = "${var.lambda_runtime}"
  description                    = "Lambda function for uploading manifests to ${var.env}-env"
  memory_size                    = "${var.lambda_memory_size}"
  timeout                        = "${var.lambda_timeout}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  environment {
    variables = {
      ApiVersion = "v1"
    }
  }

  tags = {
    Environment = "${var.env}"
    Project     = "${var.project}"
  }
}

# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "log_grp" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = 14
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.env}-lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1545132606930",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Sid": "Stmt1545132817579",
      "Action": [
        "sqs:DeleteMessage",
        "sqs:DeleteQueue",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:PurgeQueue",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:SetQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": "[${aws_sqs_queue.sqs-queue.arn},${aws_sqs_queue.sqs-queue-two.arn},${aws_sqs_queue.sqs-queue-three.arn}]"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}

# Event source from SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${aws_sqs_queue.sqs-queue.arn}"
  function_name    = "${aws_lambda_function.lambda_function.arn}"
  enabled          = true
  batch_size       = 1
}
