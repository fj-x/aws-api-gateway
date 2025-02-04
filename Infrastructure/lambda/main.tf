resource "aws_lambda_function" "one_function" {
    filename = "oneLambda.zip"
    function_name = "one"
    role = aws_iam_role.lambda_execution.arn
    runtime = "provided.al2023"
}

# Permission to allow API Gataway invoke function
resource "aws_lambda_permission" "one_function_permission" {
    statement_id = "AllowAPIGatawayInvokeCreate"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.one_function.function_name
    principal = "apigataway.amazonaws.com"
    source_arn = "${var.api_gataway_execution_arn}/*/*"
}

# Policy
resource "aws_iam_role" "lambda_exec" {
    name = "lambda_exec_role"
    assume_role_policy = [{
        Action = "sts:AsumeRole"
        Effect = "Allow"
        Principal = {
            Service = ["apigataway.amazonaws.com", "lambda.amazonaws.com"]
        }
    }]
}

resource "aws_iam_policy_attachments" "lambda_policy_attachments" {
    role = aws_iam_role.lambda_exec.name
    policy_arn = "arn:aws:iam::aws/policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "api_gtw_policy" {
    policy = <<EOF
    {
        "Version": "2012-10-17"
        "Statement": [
            "Effect": "Allow",
            "Action": ["apigateway:*"],
            "Resource": ["*"]
        ]
    }
    EOF
    role = aws_iam_role.lambda_exec.name
}

resource "aws_iam_role_policy" "sns_policy" {
    policy = <<EOF
    {
        "Version": "2012-10-17"
        "Statement": [
            "Effect": "Allow",
            "Action": ["sns:Publish"],
            "Resource": ["*"]
        ]
    }
    EOF
    role = aws_iam_role.lambda_exec.name
}

resource "aws_iam_role_policy" "ssm_policy" {
    policy = <<EOF
    {
        "Version": "2012-10-17"
        "Statement": [
            "Effect": "Allow",
            "Action": ["ssm:GetParameters"],
            "Resource": ["*"]
        ]
    }
    EOF
    role = aws_iam_role.lambda_exec.name
}

