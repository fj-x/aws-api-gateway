output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnet_ids" {
    value = [aws_subnet.subnet_one.id, aws_subnet.subnet_two.id]
}