output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "ecr_repository_url" {
  description = "최종 생성된 ECR 리포지토리 URL"
  value       = module.ecr.repository_url
}

output "sast_ip"{
    value = module.sast.public_ip
}

output "sca_ip"{
    value = module.sca.public_ip
}

output "dast_ip"{
    value = module.dast.public_ip
}

output "jenkins_ip" {
    value = module.jenkins.jenkins_ip
}

output "key_name" {
    value = module.shared_key.key_name
}