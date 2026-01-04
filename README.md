# AWS ECS Fargate Microservices – Architecture & Deployment Guide

This repository demonstrates how to design, containerize, and deploy **multiple microservices** on **AWS ECS Fargate** using **Terraform** and a **fully automated CI/CD pipeline**.

The project consists of two simple REST APIs:
- **user-service** (runs on port `3001`)
- **product-service** (runs on port `3002`)

Each service is independently built, containerized, and deployed while sharing common AWS infrastructure components.

---

## 1. Repository Structure

Each microservice is isolated in its own folder, allowing independent builds and deployments.
.
├── user-service/
│   ├── .dockerignore
│   ├── buildspec.yml
│   ├── Dockerfile
│   ├── index.js
│   └── package.json
├── product-service/
│   ├── .dockerignore
│   ├── buildspec.yml
│   ├── Dockerfile
│   ├── index.js
│   └── package.json
├── TerraformCodes/
│   └── (Includes all the terraform codes)
├── pipeline.json
├── .gitignore
└── README.md

**Why this structure?**
- Each service can be developed and deployed independently
- CI/CD pipelines can be managed per service
- Easier scalability and maintenance

---

## 2. Networking Design

The networking layer follows AWS best practices for running ECS tasks securely in private subnets.

### VPC and Subnets
- One **VPC**
- **Two public subnets** (for ALB and NAT Gateways)
- **Two private subnets** (for ECS tasks)
- Subnets are distributed across multiple Availability Zones for high availability

### Internet Access Model
- **Internet Gateway (IGW)** attached to the VPC
- Two **NAT Gateways** deployed in public subnets
- ECS tasks run in private subnets without public IPs
- NAT Gateways allow Fargate tasks in private subnets to access internet (ECR, logs) while staying private.

**Traffic flow:**
- Internet → ALB (Public Subnet)
- ALB → ECS Tasks (Private Subnet)
- ECS Tasks → NAT Gateway → Internet (Outbound only)


### Route Tables
- One public route table and two private route tables (one for each NAT gateway)
- **Public Route Table**
  - `0.0.0.0/0` routed to the Internet Gateway
- **Private Route Tables**
  - `0.0.0.0/0` routed through NAT Gateways

- Why 2 Private Route Tables? (High Availability)
  - Single Route Table is **BAD**: If NAT Gateway fails → BOTH AZs lose internet access.
  - Two Route Tables is **GOOD**: AZ1 NAT fails → AZ2 still works. Zero downtime.
  - This setup ensures that only the ALB is exposed to the internet while ECS tasks remain private.
---

## 3. Security Groups (Least Privilege Model)
Security groups are tightly scoped to allow only required traffic.
### ALB Security Group (`ecs_alb_sg`)
- **Inbound**
  - HTTP (TCP 80) from `0.0.0.0/0`
- **Outbound**
  - Traffic to ECS tasks on ports `3001` and `3002`

### ECS Tasks Security Group (`ecs_tasks_sg`)
- **Inbound**
  - Port `3001` from ALB security group (user-service)
  - Port `3002` from ALB security group (product-service)
- **Outbound**
  - Allow all outbound traffic

ECS tasks are not directly accessible from the internet and only accept traffic from the ALB.

---

## 4. Application Load Balancer

An internet-facing **Application Load Balancer (ALB)** acts as the single entry point.

### Target Groups
Two target groups:

1. user-service: port 3001 with health check path `/health`
2. product-service: port 3002 with health check path `/health`

### Listener Rules (Path-Based Routing)
- `/users*` → user-service target group
- `/products*` → product-service target group

This allows multiple services to be hosted behind a single ALB.

---

## 5. Container Registry (Amazon ECR)

Two separate **Amazon ECR repositories** are created:
- One for `user-service`
- One for `product-service`

Each service builds and pushes its Docker image to its respective repository.

---

## 6. Build Automation (AWS CodeBuild)

Each microservice has its own **CodeBuild project**.

### Responsibilities
- Authenticate with Amazon ECR
- Build Docker images
- Tag and push images to ECR

Each service defines its own `buildspec.yml`, enabling service-specific build logic.

---

## 7. ECS Cluster and Services

### ECS Cluster
- Uses **AWS Fargate**
- No EC2 instance management required

### Task Definitions
- Separate task definition per service
- Defines container image, ports, CPU, memory, and logging

### ECS Services
- One ECS service per microservice
- Uses **rolling update deployment strategy**
- Enables zero-downtime deployments

---

## 8. CI/CD Pipeline

### AWS CodePipeline Flow
1. **Source Stage**
   - Pulls code from AWS CodeCommit
2. **Build Stage**
   - Triggers CodeBuild projects for each service
3. **Deploy Stage**
   - Updates ECS services with the new container images

### EventBridge Integration
- An **EventBridge rule** monitors changes in the CodeCommit repository
- Any code push automatically triggers the pipeline

---

## 9. Key Takeaways

- Microservices architecture using AWS ECS Fargate
- Secure networking with private subnets and NAT Gateways
- Path-based routing using Application Load Balancer
- Independent builds and deployments per service
- Fully automated CI/CD using AWS native services
- Production-ready and scalable design

---
