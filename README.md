# Azure Render Farm Infrastructure (IaC)
![Terraform CI](https://github.com/ambushhere/azure-render-farm-infrastructure/actions/workflows/ci.yml/badge.svg)
<img width="2816" height="1536" alt="Gemini_Generated_Image_ao2iheao2iheao2i" src="https://github.com/user-attachments/assets/768a994f-9b0a-42d2-82e9-14441bdb6b6a" />

## Project Overview
This project demonstrates automated deployment of a scalable 3D rendering infrastructure on Microsoft Azure using **Terraform**.

Drawing from **10+ years of technical 3D production experience**, this project targets a common industry challenge: building a cost-effective, high-performance compute environment that can scale up during heavy production cycles and scale down when idle.

## Architecture
- **Infrastructure as Code:** Fully managed via Terraform.
- **Compute:** Azure Linux Virtual Machine Scale Sets (VMSS) for flexible rendering nodes.
- **Storage:** Azure Blob Storage for centralized management of textures, assets, and output frames.
- **Networking:** Isolated Virtual Network (VNet) with a dedicated subnet.

## Why This Matters
- **Scalability:** Render nodes can scale with workload demand.
- **Efficiency:** IaC reduces manual configuration errors and improves reproducibility.
- **Cost Management:** Infrastructure can be destroyed or scaled down when not in use.

## Security Defaults in This Repo
- SSH-only VM access (`disable_password_authentication = true`)
- No hardcoded admin passwords
- Storage account hardened with:
  - `min_tls_version = "TLS1_2"`
  - `allow_nested_items_to_be_public = false`

## Variables
Defined in `variables.tf`:
- `resource_group_name` (string)
- `location` (string)
- `vm_sku` (string)
- `vmss_instances` (number)
- `admin_username` (string)
- `admin_ssh_public_key` (**sensitive**, string)
- `environment` (string)

## Quick Start
1. Ensure Azure CLI and Terraform are installed.
2. Authenticate with Azure:
   ```bash
   az login
   ```
3. Prepare variables:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
4. Edit `terraform.tfvars` and set a real `admin_ssh_public_key`.
5. Initialize Terraform:
   ```bash
   terraform init
   ```
6. Validate and preview changes:
   ```bash
   terraform validate
   terraform plan
   ```
7. Deploy:
   ```bash
   terraform apply
   ```

## Destroy
```bash
terraform destroy
```

## 🐳 Containerization with Docker
This project includes a `Dockerfile` for packaging Blender into a container for headless rendering workflows.

This demonstrates:
- **Containerization:** Packaging complex software like Blender for consistent execution.
- **Microservices approach:** Running render tasks as isolated, portable containers on VMSS nodes.
- **Scalable compute:** Deploying Blender workloads across a fleet of render workers.
