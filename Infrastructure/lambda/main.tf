resource "aws_lambda_function" "one_function" {
    filename = "oneLambda.zip"
    function_name = "one"
    role = aws_iam_role.lambda_execution.arn
    runtime = "provided.al2023"
}
