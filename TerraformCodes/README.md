# Terraform codes for the project

These Terraform codes provision an **AWS ECS Fargate** environment for microservices, including networking, security, CI/CD pipelines, and application deployment.

## Structure

The project is modularized for better maintainability. The directory structure is as follows:



## Modules Overview

### VPC Module
- Creates VPC, two public and two private subnets across AZs, Internet Gateway, two Elastic IPs and NAT Gateways, public and per-private route tables, and associations.
- Public RT routes `0.0.0.0/0` to IGW; each private RT routes `0.0.0.0/0` via a NAT GW. Suitable for private ECS tasks with outbound via NAT.

### Security Module
- Creates two security groups: ALB (`ecs_alb_sg`) and ECS tasks (`ecs_tasks_sg`).
- Ingress: ALB SG allows HTTP (TCP 80) from `0.0.0.0/0`; tasks SG allows only traffic from ALB SG on service ports 3001 (user) and 3002 (product).
- Egress: tasks SG allows all outbound; ALB has explicit egress rules toward tasks on 3001/3002. Tight, least-privilege rules linking ALB ↔ tasks.

### ALB Module
- Provisions an internet-facing Application Load Balancer with provided ALB SG and two public subnets.
- Defines two target groups (`user_tg` with port 3001, `product_tg` port with 3002) with HTTP health checks on `/health`.
- Listener on port 80 with listener rules that forward paths `/users*` → user TG and `/products*` → product TG.

### CodeCommit & ECR Module
- Creates a CodeCommit repository (single repo named `${name_prefix}-code-repo`).
- Creates two ECR repositories: `user-service` and `product-service`, with `scan_on_push = true` and mutable tags.
- Intended to host source and container images for CI/CD; enable lifecycle/image-scan policies as needed.

### CodeBuild Module
- Sample CodeBuild project with supporting S3 bucket for cache/logs, IAM role + policy allowing logs, EC2/VPC operations, S3, and CodeStar Connections.
- `aws_codebuild_project` configured with environment, artifacts (NO_ARTIFACTS), S3 cache, VPC config (subnets + SGs), and source (CODECOMMIT/Git URL placeholder).
- Notes: the project uses an IAM role with broad example permissions and references example subnets/SG ARNs—adapt resource names, tighten IAM, and enable ECR permissions (ecr:*) for real Docker build/push flows.

## Terraform Backend
- The project uses a `backend.tf` file to configure remote state storage (e.g., S3 and DynamoDB).

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd TerraformCodes
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Plan the infrastructure:**
   ```bash
   terraform plan
   ```

4. **Apply the infrastructure:**
   ```bash
   terraform apply
   ```

## Variables
- Root-level and module-specific variables are defined in variables.tf and module variables.tf files.
- Configure variables such as VPC CIDR, subnets, ECS cluster name, ALB listeners, etc.

## Outputs
- Root-level outputs are defined in outputs.tf.
- Each module also exposes specific outputs (e.g., ALB DNS name, security group IDs, repository URLs).