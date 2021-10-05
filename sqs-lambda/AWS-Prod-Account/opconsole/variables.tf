variable "profile" {
  description = "AWS Profile for deployment"
  default     = "SNT-Production-Environment"
}

variable "region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "env" {
  description = "Type of Environment"
  default     = "opconsole"
}

variable "project" {
  description = "Type of Project or Project Name"
  default     = "SNT"
}

# Variables for SQS Queue
variable "sqs_name" {
  description = "Name of SQS Queue"
  default     = "sqs-queue"
}

variable "sqs_timeout" {
  description = "SQS Visibility Timeout Seconds"
  default     = "300"
}

variable "sqs_delay" {
  description = "SQS Delay Seconds"
  default     = "0"
}

variable "sqs_max_message_size" {
  description = "SQS Max Message Size"
  default     = "262144"
}

variable "sqs_message_retention_seconds" {
  description = "SQS Message Retention Seconds"
  default     = "345600"
}

variable "sqs_receive_wait_time_seconds" {
  description = "SQS Receive Wait Time Sseconds"
  default     = "0"
}

# Variables for Lambda Function
variable "iam_role_for_lambda_name" {
  description = "Name for IAM Role for Lambda Function"
  default     = "iam_role_for_lambda"
}

variable "lambda_function_name" {
  description = "Name of Lambda Function"
  default     = "ace-manifest-upload"
}

variable "lambda_handler_name" {
  description = "Name of Lambda Function Handler"
  default     = "LearningMate.Products.ACE.SqsLambda::LearningMate.Products.ACE.SqsLambda.Function::FunctionHandler"
}

variable "lambda_runtime" {
  description = "Runtime for Lambda Function"
  default     = "dotnetcore1.0"
}

variable "lambda_memory_size" {
  description = "Memory Size for Lambda Function"
  default     = "512"
}

variable "lambda_timeout" {
  description = "Time out for Lambda Function"
  default     = "900"
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions"
  default     = "1"
}
