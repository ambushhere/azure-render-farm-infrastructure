# Azure Render Farm Infrastructure (IaC)
![Terraform CI](https://github.com/ambushhere/azure-render-farm-infrastructure/actions/workflows/ci.yml/badge.svg)

## Infrastructure Architecture

```mermaid
graph LR
    User((Admin)) -->|Terraform| Azure[Azure Cloud]
    subgraph VNet [Virtual Network]
        subgraph Subnet [Render Subnet]
            VMSS[VM Scale Set: Render Nodes]
        end
        Storage[(Azure Storage: textures/frames)]
    end
    Azure --> VNet
    VMSS -.->|Read/Write| Storage
## Project Overview
This project demonstrates the automated deployment of a scalable 3D rendering infrastructure on Microsoft Azure using **Terraform**. 

Drawing from my **10+ years of experience in technical 3D production**, I designed this project to solve a common industry challenge: building a cost-effective, high-performance compute environment that can scale up during heavy production cycles and scale down to save costs.

## Architecture
- **Infrastructure as Code:** Fully managed via Terraform.
- **Compute:** Azure Linux Virtual Machine Scale Sets (VMSS) for flexible rendering nodes.
- **Storage:** Azure Blob Storage for centralized management of textures, assets, and output frames.
- **Networking:** Isolated Virtual Network (VNet) with dedicated subnets for security.

## Why This Matters
- **Scalability:** The render nodes can automatically scale based on the workload.
- **Efficiency:** Using IaC eliminates manual configuration errors and ensures reproducibility.
- **Cost Management:** Infrastructure can be destroyed or scaled to zero when not in use.

## How to Run
1. Ensure you have the Azure CLI and Terraform installed.
2. Run `terraform init` to initialize the project.
3. Run `terraform plan` to see the proposed infrastructure.
4. Run `terraform apply` to deploy.