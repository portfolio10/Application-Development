output "key_name" {
  value = aws_key_pair.ec2.key_name
}

output "private_key_pem" {
  value     = tls_private_key.ec2.private_key_pem
  sensitive = true
}