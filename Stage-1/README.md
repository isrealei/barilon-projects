
# Stage 2 - Multi-EC2 Separation

This is an extension of the [e-voting application](https://github.com/isrealei/e-voting-applcation) that will be deployed on EC2 instances, with each microservice running on a separate EC2 instance.

## Overview

This stage demonstrates the deployment of a three-tier e-voting application across multiple EC2 instances, where each microservice is isolated on its own instance for better scalability and maintainability.

## Flow of Execution

- Create a VPC with 3 public subnets, 3 private subnets, and 3 DB subnets.
- Create security groups for the services and assign specific IAM permissions.
- Create 5 EC2 instances: one for each service. The result and vote services will be in public subnets, while the worker app, Postgres, and Redis will be in private subnets. These will be bootstrapped with user-data scripts.
- Create a bastion host to access private servers running in private subnets.
- Log into each server.
- Clone the repository and add the Docker Compose file along with the required environment variables.
- Create a private hosted zone in Route 53 to map service names to private IPs for Redis and Postgres.
- Run `docker compose up`.
- Verify by casting votes.

## Architecture Diagrams

The following diagrams illustrate the application architecture and deployment strategy:

### 1. Application Workflow
![Application Workflow](diagrams/app-workflow.gif)

### 2. VPC Design
![VPC Design](diagrams/vpc-design.png)

### 3. User Workflow
![User Workflow](diagrams/user-flow.gif)

## Related Resources

- [Main E-Voting Application Repository](https://github.com/isrealei/e-voting-applcation)
- [Stage 1 - Single EC2 Deployment](../Stage%201%20–%20Single-EC2%20Deployment)


