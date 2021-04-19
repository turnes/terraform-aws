# terraform-aws
- VPC
- Fargate/ECS
- Elastic Load Balancer
- CloudWatch
- S3
- API Gateway
- Lambda
- NAT Gateway
- Elastic Cache

## Considerations

- [VPC Endpoints for ECS/Fargate](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/vpc-endpoints.html)
- 

## Module VPC
- [x] Zones
- [x] DNS hostnames
- [x] enable_dns_support
- [X] Public subnet
- [X] Private subnet
- [X] Public route
- [X] Private route
- [X] Single NAT Gateway
- [X] Multiple NAT Gateway
- [X] Map existing EIP to NAT Gateway
## Module Security Group
- [x] Create
- [x] VPC
- [x] Ingress/Egress rule by cidr blocks 
- [x] Ingress/Egress rule by security group id
- [x] Tags


## Module VPC Endpoint
  - [ ] S3 endpoint (Interface)
  - [ ] ECR endpoint (Interface)
  - [ ] Amazon CloudWatch Logs (Interface)
  - [ ] DynamoDB (Gateway)


## Module ELB Elastic Load Balancer (ALB e NLB)
- [X] Type ALB
- [ ] Type NLB
- [X] Internal / Internet facing
- [X] Cross zone load_balancing
- [x] Access Logs
- [x] Subnets
- [x] Application LB
  - [x] Security Groups
  - [x] Idle_timeout
- [x] Tags
