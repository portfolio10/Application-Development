output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
    description = "PUblic subnet ID 목록"
    value = [
        aws_subnet.public_a.id,
        aws_subnet.public_b.id
    ]
}

output "shared_security_group_id" {
  value = aws_security_group.shared_sg.id
}