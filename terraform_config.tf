provider "aws" {
  access_key = "yourkey"
  secret_key = "yoursecret"
  region     = "us-west-2"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_lambda_function" "first_lambda" {
  filename = "FirstLambda/FirstLambda-CurrentDeploy.zip"
  function_name = "first_lambda"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "FirstLambda::FirstLambda.FunctionHandler::Handle"
  runtime = "dotnetcore1.0"
  source_code_hash = "${base64sha256(file("FirstLambda/FirstLambda-CurrentDeploy.zip"))}"
  publish = true
}
