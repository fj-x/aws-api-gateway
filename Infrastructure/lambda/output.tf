output "lambda_one_function_arn" {
    value = aws_lambda_function.one_function.invoke_arn
}