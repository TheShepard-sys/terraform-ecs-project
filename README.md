# Terraform ECS DevSecOps Project

## Overview

This project provisions a **secure, containerised AWS infrastructure using Terraform**, following modern DevOps and DevSecOps practices.

It automates the deployment of:

* Amazon ECS (Fargate)
* Amazon ECR
* IAM roles and policies
* Remote Terraform state (S3 + DynamoDB)
* CI/CD pipeline using GitHub Actions with OIDC authentication

---

## Key Features

* Infrastructure as Code (Terraform)
* Modular architecture (ECR, ECS, IAM)
* Remote state stored in S3
* State locking via DynamoDB
* Multi-environment support (dev, staging, prod)
* CI/CD pipeline via GitHub Actions
* OIDC authentication (no AWS access keys)
* Least privilege IAM principles

---

## Architecture

GitHub Actions
→ OIDC Authentication
→ AWS IAM Role
→ Terraform
→ ECS (Fargate)
→ Running Container from ECR

---

## Project Structure

```bash
.
├── main.tf
├── variables.tf
├── README.md
├── .gitignore
├── modules/
│   ├── ecr/
│   ├── ecs/
│   └── iam/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
└── .github/workflows/
    └── terraform.yml
```

> Note: `.terraform/` and `*.tfstate` files are excluded as they are local/generated files.

---

## Security

* No hardcoded AWS credentials
* OIDC used for secure GitHub → AWS authentication
* Temporary credentials (short-lived)
* Terraform state stored securely in S3
* State locking prevents concurrent changes
* IAM roles scoped to required permissions

---

## How It Works

1. Code is pushed to GitHub
2. GitHub Actions pipeline is triggered
3. OIDC authenticates GitHub with AWS
4. Terraform initializes remote state
5. Terraform plans infrastructure changes
6. Terraform applies changes
7. ECS service deploys container

---

## Run Locally

```bash
terraform init
terraform plan -var-file="environments/dev/terraform.tfvars"
terraform apply -auto-approve -var-file="environments/dev/terraform.tfvars"
```

---

## CI/CD Pipeline

The GitHub Actions workflow:

* Authenticates to AWS using OIDC
* Runs Terraform init
* Executes Terraform plan
* Applies infrastructure automatically

---

## Future Improvements

* Add Application Load Balancer (ALB)
* Implement auto-scaling policies
* Introduce monitoring (CloudWatch / Prometheus / Grafana)
* Improve IAM least privilege policies
* Add environment isolation improvements

---

## Summary

This project demonstrates:

* Terraform-based infrastructure design
* Secure CI/CD implementation using OIDC
* AWS container orchestration with ECS
* Real-world DevOps and DevSecOps practices

It reflects practical experience with cloud infrastructure automation and secure deployment pipelines.
