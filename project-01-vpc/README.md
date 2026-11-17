# Project 01 – AWS VPC Infrastructure using Terraform

## Overview

This project demonstrates how to provision a secure and scalable AWS Virtual Private Cloud (VPC) infrastructure using Terraform.

The infrastructure is deployed locally using Floci for AWS service simulation and Terraform for Infrastructure as Code (IaC).

## Architecture

The VPC contains:

- One VPC
- Two public subnets across two Availability Zones
- Two private subnets across two Availability Zones
- One Internet Gateway
- One NAT Gateway with an Elastic IP
- Public and private route tables
- Public and private security groups
- One S3 Gateway VPC Endpoint

## Technologies

- Terraform
- AWS VPC
- AWS Networking
- AWS CLI
- Floci
- macOS

## Network Design

### VPC Configuration

| Component  | Configuration  |
| ---------- | -------------- |
| VPC Name   | enterprise-vpc |
| VPC ID     | vpc-2fe5fe3c   |
| VPC CIDR   | 10.0.0.0/16    |
| AWS Region | us-east-1      |

### Subnet Allocation

| Subnet           | CIDR Block   | Availability Zone | Type    |
| ---------------- | ------------ | ----------------- | ------- |
| Public Subnet 1  | 10.0.1.0/24  | us-east-1a        | Public  |
| Public Subnet 2  | 10.0.2.0/24  | us-east-1b        | Public  |
| Private Subnet 1 | 10.0.11.0/24 | us-east-1a        | Private |
| Private Subnet 2 | 10.0.12.0/24 | us-east-1b        | Private |

### Why Two Public and Two Private Subnets?

- Public subnets host internet-facing resources such as an Application Load Balancer.
- Private subnets host application servers and backend resources.
- Two Availability Zones improve availability if one zone experiences an issue.
- Private resources can use the NAT Gateway for outbound internet access without receiving direct inbound internet connections.

## Routing Architecture

### Internet Gateway

The Internet Gateway (IGW) allows resources in public subnets to communicate with the internet when their network configuration and security rules permit it.

- Internet Gateway ID: igw-d14385ed
- Attached to: enterprise-vpc

### Public Route Table

- Route Table ID: rtb-b244cb51
- Associated with both public subnets.

| Destination | Target           |
| ----------- | ---------------- |
| 10.0.0.0/16 | Local            |
| 0.0.0.0/0   | Internet Gateway |

### NAT Gateway

The NAT Gateway allows resources in private subnets to initiate outbound internet connections without being directly reachable through the internet.

- NAT Gateway ID: nat-21c943cf5c0fe80e2
- Elastic IP: 54.93.40.168
- Located in public subnet 1

### Private Route Table

- Route Table ID: rtb-24fdd7b0
- Associated with both private subnets.

| Destination | Target      |
| ----------- | ----------- |
| 10.0.0.0/16 | Local       |
| 0.0.0.0/0   | NAT Gateway |

### Traffic Flow

**Public subnet:**

Internet → Internet Gateway → Public Subnet

**Private subnet outbound traffic:**

Private Subnet → NAT Gateway → Internet Gateway → Internet

**Important:** The NAT Gateway supports outbound connections initiated by private resources. It does not provide direct inbound internet access to those resources.

## Security Groups

Security groups act as virtual firewalls that control inbound and outbound traffic.

### Public Security Group

- Name: enterprise-vpc-public-sg
- ID: sg-7df1ed73a29c8da1e

| Direction | Protocol | Port | Source    |
| --------- | -------- | ---- | --------- |
| Inbound   | TCP      | 80   | 0.0.0.0/0 |
| Inbound   | TCP      | 443  | 0.0.0.0/0 |
| Outbound  | All      | All  | 0.0.0.0/0 |

### Private Security Group

- Name: enterprise-vpc-private-sg
- ID: sg-e708e2c67a0afafea

| Direction | Protocol | Port | Source                |
| --------- | -------- | ---- | --------------------- |
| Inbound   | TCP      | 8080 | Public Security Group |
| Outbound  | All      | All  | 0.0.0.0/0             |

The private security group allows application traffic on port 8080 only from the public security group.

## S3 Gateway VPC Endpoint

A Gateway VPC Endpoint provides private connectivity from a VPC to Amazon S3 without requiring traffic to use a NAT Gateway or Internet Gateway.

- Endpoint ID: vpce-b5a5dbb02646a9533
- Endpoint Type: Gateway
- Service: com.amazonaws.us-east-1.s3
- Associated Route Table: rtb-24fdd7b0
- State: Available

This endpoint is associated with the private route table.

## Terraform Commands

### Initialize Terraform

Downloads the required Terraform providers and initializes the working directory.

```bash
terraform init
```

### Validate Configuration

Checks Terraform syntax and configuration.

```bash
terraform validate
```

### Preview Infrastructure Changes

Shows what Terraform plans to create, modify, or destroy.

```bash
terraform plan
```

### Create or Update Infrastructure

Applies the Terraform configuration.

```bash
terraform apply
```

### View Terraform Outputs

Displays resource IDs and other configured outputs.

```bash
terraform output
```

### View Managed Resources

Lists resources tracked in Terraform state.

```bash
terraform state list
```

### Destroy Infrastructure

Destroys resources managed by this Terraform configuration.

```bash
terraform destroy
```

**Warning:** `terraform destroy` deletes the infrastructure. Use it only when you intentionally want to remove the project resources.

## Project Validation

The following components were verified using AWS CLI commands against the local Floci endpoint:

- VPC and subnet configuration
- Internet Gateway
- Public and private route tables
- Route table associations
- NAT Gateway state: Available
- NAT Elastic IP association: Succeeded
- Public and private Security Groups
- S3 Gateway VPC Endpoint state: Available
- Terraform plan: No changes

## Environment

This project was created using Terraform and Floci on macOS.

**Note:** Floci simulates AWS services locally. Successful resource validation in Floci does not prove real AWS internet connectivity or production behavior.
