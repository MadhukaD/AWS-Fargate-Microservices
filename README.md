# Creating ECR repositories
```
aws ecr create-repository --repository-name product-service --region ap-southeast-1
aws ecr create-repository --repository-name user-service --region ap-southeast-1
```

# Authenticate Docker to your ECR registry
```
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 348184816643.dkr.ecr.ap-southeast-1.amazonaws.com
```

# Build Docker images locally
```
cd user-service
npm install
docker build -t user-service .
cd ../product-service
npm install
docker build -t product-service .
```

# Tag your Docker images to point to ECR repositories
```
docker tag user-service:latest 348184816643.dkr.ecr.ap-southeast-1.amazonaws.com/user-service:latest
docker tag product-service:latest 348184816643.dkr.ecr.ap-southeast-1.amazonaws.com/product-service:latest
```

# Push the tagged images to ECR
```
docker push 348184816643.dkr.ecr.ap-southeast-1.amazonaws.com/user-service:latest
docker push 348184816643.dkr.ecr.ap-southeast-1.amazonaws.com/product-service:latest
```

# Create the IAM role for CodeBuild
Go to IAM and create a new role
Attach the following policies:
- AmazonEC2ContainerRegistryPowerUser
- AmazonECS_FullAccess
- AmazonS3ReadOnlyAccess
- AWSCodeBuildDeveloperAccess
- CloudWatchLogsFullAccess
Click next and add the following trust policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

# Step-by-step to create a CodeBuild project:
Open the AWS Management Console, go to CodeBuild service.

- Click Create Project
- Give your project a name like user-service-build (and later product-service build).
- In Source, choose GitHub (connect your GitHub repo with OAuth or token).
- Specify the repo and the branch you want to build.
- Environment Configuration:
    - Environment image: Choose Managed image.
    - Operating system: Amazon Linux 2.
    - Runtime: Standard.
    - Image: aws/codebuild/standard:5.0 (supports Docker).
- Enable Privileged mode (important for Docker build).
- Service role: Choose the IAM role you created for CodeBuild (with ECR, ECS, and CloudWatch permissions).
- Buildspec: Either use a buildspec.yml file in your repo root (recommended) or provide inline build commands. Use the earlier shared buildspec.yml example (adjust IMAGE_REPO_NAME and other variables).
- Environment variables: Optionally set environment variables like AWS_REGION, IMAGE_REPO_NAME for flexibility.
- Logs and artifacts: Enable CloudWatch Logs for build logs.
- Save and create the project.