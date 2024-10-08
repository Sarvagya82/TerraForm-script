Certainly! I'll prepare a comprehensive document outlining the project we've created. This document will serve as a summary and reference for the WordPress on ECS project using Terraform.

---

# WordPress on ECS with ALB, RDS, and Secrets Manager

## Project Overview

This project deploys a scalable WordPress application using Amazon ECS (Elastic Container Service) with an Application Load Balancer (ALB), Amazon RDS for the database, and AWS Secrets Manager for secure credential management. The infrastructure is defined and managed using Terraform.

## Infrastructure Components

1. **VPC (Virtual Private Cloud)**
   - Custom VPC with public and private subnets across two availability zones
   - Internet Gateway for public internet access
   - NAT Gateways for private subnet internet access
   - Route tables for traffic management

2. **ECS (Elastic Container Service)**
   - ECS Cluster running in private subnets
   - Task Definition using the official WordPress Docker image
   - ECS Service to maintain desired number of tasks
   - Service Discovery for inter-service communication

3. **RDS (Relational Database Service)**
   - MySQL instance deployed in private subnets
   - Multi-AZ deployment for high availability
   - Subnet group and security group for network isolation

4. **Secrets Manager**
   - Stores RDS database credentials securely
   - Allows secure access from ECS tasks

5. **ALB (Application Load Balancer)**
   - Deployed in public subnets
   - Handles incoming HTTP/HTTPS traffic
   - SSL/TLS termination
   - HTTP to HTTPS redirection

6. **Route 53**
   - DNS management for the domain
   - A record pointing to the ALB

7. **ACM (AWS Certificate Manager)**
   - Manages SSL/TLS certificate for the domain

8. **IAM (Identity and Access Management)**
   - Roles and policies for ECS tasks
   - Permissions to access Secrets Manager

## Terraform Structure

The project uses a modular Terraform structure:

- `main.tf`: Main configuration file that calls all modules
- `variables.tf`: Variable definitions
- `outputs.tf`: Output values
- `terraform.tfvars`: Variable values (not committed to version control)

Modules:
- `vpc`: VPC and networking components
- `ecs`: ECS cluster, service, and task definitions
- `rds`: RDS instance and related resources
- `secrets-manager`: Secrets management
- `alb`: Application Load Balancer and related resources
- `iam`: IAM roles and policies

## Key Configurations

- Region: ap-south-1 (Mumbai)
- Availability Zones: ap-south-1a, ap-south-1b
- Domain: awswordpress.me
- ECS Task: WordPress Docker image
- RDS: MySQL 8.0
- ALB: HTTP to HTTPS redirection

## Deployment Process

1. Initialize Terraform: `terraform init`
2. Plan the deployment: `terraform plan`
3. Apply the configuration: `terraform apply`

## Security Considerations

- All sensitive data stored in AWS Secrets Manager
- Private subnets used for ECS tasks and RDS
- Security groups restricting access
- HTTPS enforced with HTTP to HTTPS redirection

## Scalability and High Availability

- ECS allows easy scaling of WordPress containers
- ALB distributes traffic across multiple containers
- RDS with Multi-AZ deployment for database high availability

## Monitoring and Logging

- CloudWatch for monitoring ECS and RDS metrics
- CloudWatch Logs for container logs

## Cost Optimization

- Use of t3 instance types for cost-effective performance
- Auto-scaling capabilities to match demand



