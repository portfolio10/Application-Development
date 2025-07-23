module "jenkins" {
  source               =  "./modules/jenkins"

  ami_id               = var.jenkins_ami_id

  subnet_id            = module.network.public_subnet_ids[0]  # ✅ AZ1에 생성
  vpc_id               = module.network.vpc_id                # 기존 사용 중이라면 유지

  shared_key_name      = module.shared_key.key_name
  security_group_id    = module.network.shared_security_group_id
}

module "shared_key" {
  source               = "./modules/shared_key"
}

module "network" {
  source               = "./modules/network"
  name_prefix          = "infra"
}

module "ecr"{
  source               = "./modules/ecr"
  repository_name      = var.ecr_repository_name
}

module "sast" {
  source              = "./modules/sast"
  ami_id              = var.sast_ami_id
  subnet_id           = module.network.public_subnet_ids[0]
  security_group_id   = module.network.shared_security_group_id
  shared_key_name     = module.shared_key.key_name
}

module "sca"{
  source              = "./modules/sca"
  ami_id              =  var.sca_ami_id
  subnet_id           = module.network.public_subnet_ids[0]
  security_group_id   = module.network.shared_security_group_id
  shared_key_name     = module.shared_key.key_name
}

module "dast"{
  source              = "./modules/dast"
  ami_id              =  var.dast_ami_id
  subnet_id           = module.network.public_subnet_ids[0]
  security_group_id   = module.network.shared_security_group_id
  shared_key_name     = module.shared_key.key_name
}

module "lambda_iam" {
  source         = "./modules/lambda/iam"
  name           = "lambda-common-role"
  s3_bucket_arn  = "arn:aws:s3:::webgoat-codedeploy-bucket" # 예시, 실제 값에 맞게 수정
}

module "s3" {
  source = "./modules/s3"

  dast_s3_bucket_name = var.dast_s3_bucket_name
  sast_s3_bucket_name = var.sast_s3_bucket_name
}

module "lambda_sast" {
  source              = "./modules/lambda/sast"
  function_name       = "sast-s3-trigger-lambda"
  iam_role_arn        = module.lambda_iam.role_arn
  slack_webhook_url   = var.sast_slack_webhook_url
  sast_s3_bucket_name      = module.s3.sast_s3_bucket_name
  sast_s3_filter_prefix    = var.sast_s3_filter_prefix
  sast_s3_bucket_arn       = module.s3.sast_s3_bucket_arn
}

module "lambda_dast" {
  source              = "./modules/lambda/dast"
  function_name       = "dast-s3-trigger-lambda"
  iam_role_arn        = module.lambda_iam.role_arn
  slack_webhook_url   = var.dast_slack_webhook_url
  dast_s3_bucket_name      = module.s3.dast_s3_bucket_name
  dast_s3_filter_prefix    = var.dast_s3_filter_prefix
  dast_s3_bucket_arn       = module.s3.dast_s3_bucket_arn
}

module "alb" {
  source                   = "./modules/alb"
  vpc_id                   = module.network.vpc_id
  public_subnet_ids        = module.network.public_subnet_ids
  alb_security_group_id    = module.shared_security_group_id
  alb_certificate_arn      = var.alb_certificate_arn #이것도 자동 생성으로 박아야 함.
  alb_name                 = var.alb_name
}

module "codedeploy" {
  source                   = "./modules/codedeploy"
  project_name             = var.project_name

  ecs_cluster_name         = module.ecs.cluster_name
  ecs_service              = module.ecs.service_name

  listener_arn             = module.alb.listener_arn
  blue_target_group_name   = module.alb.blue_target_group_name
  green_target_group_name  = module.alb.green_target_group_name
}