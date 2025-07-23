output "codedeploy_app_name" {
  value = aws_codedeploy_app.ecs_app.name
}

output "codedeploy_deploy_group" {
  value = aws_codedeploy_deployment_group.ecs_deployment_group.deployment_group_name
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}
