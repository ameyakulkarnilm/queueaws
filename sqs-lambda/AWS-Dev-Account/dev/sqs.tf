resource "aws_sqs_queue" "sqs-queue" {
  name                       = "${var.sqs_name}-${var.env}-env"
  visibility_timeout_seconds = "${var.sqs_timeout}"
  delay_seconds              = "${var.sqs_delay}"
  max_message_size           = "${var.sqs_max_message_size}"
  message_retention_seconds  = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds  = "${var.sqs_receive_wait_time_seconds}"

  tags = {
    Environment = "${var.env}"
    Project     = "${var.project}"
  }
}

resource "aws_sqs_queue" "sqs-queue-two" {
  name                       = "${var.sqs_name}-${var.env}-two"
  visibility_timeout_seconds = "${var.sqs_timeout}"
  delay_seconds              = "${var.sqs_delay}"
  max_message_size           = "${var.sqs_max_message_size}"
  message_retention_seconds  = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds  = "${var.sqs_receive_wait_time_seconds}"

  tags = {
    Environment = "${var.env}"
    Project     = "${var.project}"
  }
}

resource "aws_sqs_queue" "sqs-queue-three" {
  name                       = "${var.sqs_name}-${var.env}-three"
  visibility_timeout_seconds = "${var.sqs_timeout}"
  delay_seconds              = "${var.sqs_delay}"
  max_message_size           = "${var.sqs_max_message_size}"
  message_retention_seconds  = "${var.sqs_message_retention_seconds}"
  receive_wait_time_seconds  = "${var.sqs_receive_wait_time_seconds}"

  tags = {
    Environment = "${var.env}"
    Project     = "${var.project}"
  }
}


resource "aws_sqs_queue_policy" "sqs-queue-policy" {
  queue_url = "${aws_sqs_queue.sqs-queue.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
      "sqs:DeleteMessage",
      "sqs:DeleteQueue",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
      ],
      "Resource": "${aws_sqs_queue.sqs-queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs-queue.arn}"
        }
      }
    }
  ]
}
POLICY
}


resource "aws_sqs_queue_policy" "sqs-queue-policy-two" {
  queue_url = "${aws_sqs_queue.sqs-queue-two.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
      "sqs:DeleteMessage",
      "sqs:DeleteQueue",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
      ],
      "Resource": "${aws_sqs_queue.sqs-queue-two.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs-queue-two.arn}"
        }
      }
    }
  ]
}
POLICY
}


resource "aws_sqs_queue_policy" "sqs-queue-policy-three" {
  queue_url = "${aws_sqs_queue.sqs-queue-three.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
      "sqs:DeleteMessage",
      "sqs:DeleteQueue",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
      ],
      "Resource": "${aws_sqs_queue.sqs-queue-three.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs-queue-three.arn}"
        }
      }
    }
  ]
}
POLICY
}
