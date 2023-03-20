resource "aws_lambda_function" "teamf_lambda" {
  function_name = "teamf-lambda"
  handler = "index.handler"
  runtime = "nodejs18.x"
  memory_size = 128
  timeout = 10
  filename = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}