variable "access_key" {
  default = "YOUR ACCESS KEY"
}

variable "secret_key" {
  default = "YOUR KEY"
}

variable "account_id" {
  default = "YOUR ACCOUNT ID"
}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
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
        "Service": [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com"
        ]
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
  timeout = 10
}

resource "aws_api_gateway_rest_api" "first_lambda_api" {
  name = "FirstLambdaAPI"
  description = "The First Lambda RestAPI"
}

resource "aws_api_gateway_resource" "first_lambda_api_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.first_lambda_api.id}"
  parent_id = "${aws_api_gateway_rest_api.first_lambda_api.root_resource_id}"
  path_part = "firstlambda"
}

resource "aws_api_gateway_method" "first_lambda_api_method" {
  rest_api_id = "${aws_api_gateway_rest_api.first_lambda_api.id}"
  resource_id = "${aws_api_gateway_resource.first_lambda_api_resource.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_lambda_permission" "first_lambda_api_to_lambda_permission" {
  depends_on = [
    "aws_api_gateway_method.first_lambda_api_method",
  ]
  statement_id = "AllowExecutionFromAPIGatewayMethod"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.first_lambda.function_name}"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.first_lambda_api.id}/*/${aws_api_gateway_integration.first_lambda_api_method_integration.integration_http_method}${aws_api_gateway_resource.first_lambda_api_resource.path}"
}

resource "aws_api_gateway_integration" "first_lambda_api_method_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.first_lambda_api.id}"
  resource_id = "${aws_api_gateway_resource.first_lambda_api_resource.id}"
  http_method = "${aws_api_gateway_method.first_lambda_api_method.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${aws_lambda_function.first_lambda.function_name}/invocations"
  integration_http_method = "POST" // LAMBDA FUNCTIONS ONLY ACCEPT POST
}

resource "aws_api_gateway_deployment" "first_lambda_deployment_dev" {
  depends_on = [
    "aws_api_gateway_method.first_lambda_api_method",
    "aws_api_gateway_integration.first_lambda_api_method_integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.first_lambda_api.id}"
  stage_name = "dev"
}

resource "aws_api_gateway_deployment" "first_lambda_deployment_prod" {
  depends_on = [
    "aws_api_gateway_method.first_lambda_api_method",
    "aws_api_gateway_integration.first_lambda_api_method_integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.first_lambda_api.id}"
  stage_name = "api"
}

output "dev_url" {
  value = "https://${aws_api_gateway_deployment.first_lambda_deployment_dev.rest_api_id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.first_lambda_deployment_dev.stage_name}"
}

output "prod_url" {
  value = "https://${aws_api_gateway_deployment.first_lambda_deployment_prod.rest_api_id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.first_lambda_deployment_prod.stage_name}"
}
