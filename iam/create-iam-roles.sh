#!/bin/bash
set -e

ACCOUNT_ID=348184816643
REGION=ap-southeast-1
BUCKET=codepipeline-artifacts-$ACCOUNT_ID

echo "=== Creating S3 artifact bucket if not exists ==="
aws s3 mb s3://$BUCKET --region $REGION || echo "Bucket exists"

echo "=== Creating ecsTaskExecutionRole ==="
aws iam create-role \
  --role-name ecsTaskExecutionRole \
  --assume-role-policy-document file://ecs-task-exec-trust.json || echo "Role exists"

aws iam attach-role-policy \
  --role-name ecsTaskExecutionRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

echo "=== Creating ecsTaskRole ==="
aws iam create-role \
  --role-name ecsTaskRole \
  --assume-role-policy-document file://ecs-task-role-trust.json || echo "Role exists"

echo "=== Creating CodeBuild role ==="
aws iam create-role \
  --role-name codebuild-service-role \
  --assume-role-policy-document file://codebuild-trust.json || echo "Role exists"

aws iam put-role-policy \
  --role-name codebuild-service-role \
  --policy-name CodeBuildLeastPrivilege \
  --policy-document file://codebuild-leastpriv-policy.json

echo "=== Creating CodeDeploy role ==="
aws iam create-role \
  --role-name CodeDeployECSServiceRole \
  --assume-role-policy-document file://codedeploy-trust.json || echo "Role exists"

aws iam attach-role-policy \
  --role-name CodeDeployECSServiceRole \
  --policy-arn arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS

echo "=== Creating CodePipeline role ==="
aws iam create-role \
  --role-name CodePipelineServiceRole \
  --assume-role-policy-document file://codepipeline-trust.json || echo "Role exists"

aws iam put-role-policy \
  --role-name CodePipelineServiceRole \
  --policy-name CodePipelineLeastPrivilege \
  --policy-document file://codepipeline-leastpriv-policy.json

echo
echo "==== IAM Roles Created Successfully ===="
echo "ecsTaskExecutionRole ARN: arn:aws:iam::$ACCOUNT_ID:role/ecsTaskExecutionRole"
echo "ecsTaskRole ARN: arn:aws:iam::$ACCOUNT_ID:role/ecsTaskRole"
echo "CodeBuild Role ARN: arn:aws:iam::$ACCOUNT_ID:role/codebuild-service-role"
echo "CodeDeploy Role ARN: arn:aws:iam::$ACCOUNT_ID:role/CodeDeployECSServiceRole"
echo "CodePipeline Role ARN: arn:aws:iam::$ACCOUNT_ID:role/CodePipelineServiceRole"
