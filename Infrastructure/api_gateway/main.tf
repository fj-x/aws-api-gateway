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
    throttle_settings {
        burst_limit = 50
        rate_limit = 20
    }
    quota_settings {
        limit = 500
        period = "MONTH"
        offset = 0
    }
}

resource "aws_api_gateway_api_key" "api_key" {
    name = "first_key"
    enabled = true
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
    key_id = aws_api_gateway_api_key.api_key.id
    key_type = "API_KEY"
    usage_plan_id = aws_api_gateway_usage_plan.usage_plan_one
}

resource "aws_api_gateway_model" "post_model" {
    rest_api_id = aws_api_gateway_rest_api.rest_api.id
    name = "PostModel"
    content_type = "application/json"
    schema = <<EOF
    {
        "$schema": "http://json-scema.org/draft-04/schema#",
        "title": "Post Scema",
        "type": "object",
        "properties": {
            "first": {"type":"string"},
            "second": {"type":"boolean"},
        },
        "required": [
            "first",
            "second"
        ]
    }
    EOF
}

resource "aws_api_gateway_request_validator" "first_validator" {
    name = "first_validator"
    rest_api_id = aws_api_gateway_rest_api.rest_api_id.id
    validate_request_body = true
    validate_request_parameters = true
}
