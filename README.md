# terraform-aws
Some modules for terraform

## VPC
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
- [ ] Endpoints

## Module Security Group
- [x] Create
- [x] VPC
- [x] Ingress/Egress rule by cidr blocks 
- [x] Ingress/Egress rule by security group id
- [x] Tags


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
