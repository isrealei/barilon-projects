# Three-Tier Web Application - E-Voting App

This is a comprehensive e-voting application deployed on AWS, demonstrating various cloud architectures and deployment strategies. The project progresses from simple single-instance deployments to complex, highly available architectures using modern DevOps practices.

## Project Overview

This repository showcases the evolution of a three-tier e-voting application through multiple deployment stages, each increasing in complexity and demonstrating different AWS services and architectural patterns.

## Deployment Stages

### Stage 1: Single EC2 Deployment
Deploying all microservices using one EC2 instance per service

### Stage 2: Multi-EC2 with Managed Services
Deploying all microservices on separate EC2 instances while leveraging AWS RDS and ElastiCache instead of containerized Postgres and Redis

### Stage 3: Auto Scaling and Load Balancing
Using Auto Scaling Groups for services and incorporating AWS Load Balancers and Target Groups. This stage includes failure simulation and testing.

### Stage 4: Container Orchestration with ECS
Deploying the application using AWS ECS (Elastic Container Service)

### Stage 5: Infrastructure as Code and CI/CD
Deploying all of the above using Infrastructure as Code (IaC) and implementing CI/CD pipelines

### Stage 6: Kubernetes Deployment
Deploying the application to Kubernetes for container orchestration

## Application Architecture

This e-voting application follows a three-tier architecture:
- **Presentation Tier**: Web interface for voters and administrators
- **Application Tier**: Business logic and API services
- **Data Tier**: Database and caching layers

## Getting Started

Each stage has its own directory with detailed instructions and documentation. Navigate to the specific stage directory to get started with that deployment method.

## Technologies Used

- **Cloud Platform**: AWS
- **Containerization**: Docker
- **Orchestration**: Kubernetes, AWS ECS
- **Infrastructure**: Terraform/CloudFormation
- **CI/CD**: AWS CodePipeline, GitHub Actions
- **Database**: PostgreSQL (RDS)
- **Caching**: Redis (ElastiCache)
- **Load Balancing**: Application Load Balancer (ALB)
- **Auto Scaling**: Auto Scaling Groups
- **DNS**: Route 53 

