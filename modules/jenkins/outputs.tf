output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_id" {
  value = aws_instance.jenkins.id
}
