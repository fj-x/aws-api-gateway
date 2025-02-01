provider "aws" {
    region = "eu-west-1"
    profile = "aws-api-g"
}

module "network" {
    source = "./modules/network"
}

module "api_gateway" {
    source = "./modules/api_gateway"
    lambda_one_function_arn = module.lambda.lambda_one_function_arn
}

module "lambda" {
    source = "./modules/lambda"
}