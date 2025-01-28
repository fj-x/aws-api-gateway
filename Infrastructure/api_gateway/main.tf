resource "aws_api_gateway_rest_api" "rest_api" {
    name = "Boilerplate API"
}

resource "aws_api_gateway_deployment" "rest_api_deployment" {
    rest_api_id = aws_api_gateway_rest_api.rest_api.id
}

resource "aws_api_stage" "rest_api_stage" {
    stage_name = "stage-one"
    rest_api_id = aws_api_gataway_rest_api.rest_api.id
    deployment_id = aws_api_gateway_deployment.rest_api_deployment.id
}

resource "aws_api_gateway_resource" "resource_one" {
    rest_api_id = aws_api_gateway_rest_api.rest_api.id
    parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
    path_part = "path_one"
}

resource "aws_api_gateway_usage_plan" "usage_plan_one" {
    name = "plan_one"
    throttle_settings = {
        burst_limit = 50
        rate_limit = 20
    }
    quota_settings = {
        limit = 500
        period = "MONTH"
        offset = 0
    }
}