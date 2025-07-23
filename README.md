# 🛠️ Terraform 기반 AWS CI/CD 인프라 구축

이 프로젝트는 **Terraform IaC(Infra as Code)** 기반으로 AWS에 Jenkins 중심의 CI/CD 파이프라인 및 보안 분석 도구 환경을 자동화하는 구성을 담고 있습니다.  
**모듈화 설계**로 유지보수성과 확장성을 확보하였으며, AMI 기반의 EC2 생성 방식으로 신속한 인스턴스 배포가 가능합니다.

---

## 🧭 전체 구성도

```plaintext

    webhook
       ↓
GitHub → Jenkins(CI) → ECR → Codedeploy(ECS)  
               ↓        ↓(pull)
     [SAST] [SCA] [DAST]
               ↓
               ↓
               ↓
               s3
               ↓
            lambda → securityhub → lambda → slack

- 인프라팀이 codedeploy 부분을 맡아주기로 해서 ecr 까지 만들었지만 분석도구 알림은    
  우리가 해야하는게 맞지않을까?

## 디렉토리 구조
terraform/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── modules/
│   ├── network/              # VPC, 서브넷, IGW 등 네트워크 구성
│   ├── security_group/       # 공용 보안 그룹 (모든 EC2 공유 사용)
│   ├── jenkins/              # Jenkins EC2 인스턴스
│   ├── sast/                 # SonarQube 인스턴스 (SAST)
│   ├── sca/                  # Dependency-Check 인스턴스 (SCA)
│   ├── dast/                 # OWASP ZAP 인스턴스 (DAST)
│   └── ecr/                  # Docker 이미지 저장소

20250719 1907부 수정
- 기존 IaC용 iam과 keypair를 사용하던 방식에서 인스턴스 별 iam 생성 및 IaC용 keypair 
  생성 후 사용하도록 변경

- IaC용 iam과 keypair는 테라폼 클라우드에서 갖고오므로 유지 ..

나는 감쟈 뭐해야하지 

20250720 1800부 lambda 만들기 시작

20250721 2300부 1단계 람다 및 s3 생성 완료.

20250723 ecs, codedeploy, alb 생성 시작. subin 폴더 추가

20250723 1640부 
- aws상에서 route53 설정 완료 후 acm 권한도 For_jenkins에 넣어줌. iac코드 반영은 안함.
- (root/main.tf)alb_certificate_arn      = var.alb_certificate_arn #이것도 자동 
  생성으로 박아야 함.