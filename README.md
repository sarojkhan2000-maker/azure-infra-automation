# Azure Infra Automation Lab

## Project Overview
This project demonstrates Azure infrastructure automation using Bicep, Azure Automation Runbooks, Terraform, Azure Monitor, Blob Storage, and basic CI/CD validation.

## What This Project Does
- Creates Azure VMs from a Golden Image
- Uses Bicep for VM deployment
- Converts Bicep to ARM JSON for Runbook execution
- Stores ARM JSON template in Azure Blob Storage
- Uses Azure Automation Runbooks for VM operations
- Uses Azure Run Command to execute cleanup scripts inside VMs
- Uses Azure Monitor / VM monitoring for infrastructure visibility
- Uses Terraform to create basic Azure networking resources
- Uses GitHub Actions to validate Bicep and Terraform code

## Architecture

Azure Compute Gallery Image
        ↓
Bicep Template → ARM JSON
        ↓
Blob Storage
        ↓
Automation Runbook
        ↓
Azure VM Created / VM Action Executed

## Azure Resources Used
- Resource Group: `rg-infra-lab`
- VNet: `vnet-infra`
- Subnet: `subnet-vm`
- NSG: `nsg-vm`
- Azure Compute Gallery: `gal_infra_lab`
- Image Definition: `img-win-base-def`
- Image Version: `0.0.1`
- Storage Account: `stinfrabicep2026`
- Blob Container: `bicep-templates`
- Automation Account: `aa-infra-automation`
- Log Analytics / VM Monitoring: enabled for VM monitoring
- Data Collection Rule / Azure Monitor Agent: explored and configured during monitoring setup

## Runbooks Created
- `rb-create-vm-bicep` — Creates VM from Golden Image using ARM JSON stored in Blob
- `rb-start-vm` — Starts/powers on a VM
- `rb-stop-vm` — Stops/deallocates a VM
- `rb-clear-temp-folder` — Clears temp folder inside VM using Azure Run Command

## Bicep Features
- VM name parameter
- VM size parameter
- Location parameter
- VNet/Subnet parameters
- Image ID parameter
- Secure password handling using `@secure()`
- Trusted Launch enabled
- Standard Public IP
- Deployment output message

## Automation Security
- Automation Account uses Managed Identity
- Managed Identity assigned Contributor access on Resource Group
- Managed Identity assigned Storage Blob Data Reader on Storage Account
- VM admin credential stored securely in Automation Account Credential asset

## Monitoring Setup
- Enabled Azure VM monitoring
- Installed/validated Azure Monitor Agent
- Explored Log Analytics Workspace and Data Collection Rule flow
- Monitoring is planned for future chatbot queries such as CPU, RAM, and disk usage

## Terraform Demo
Terraform creates:
- Resource Group
- Virtual Network
- Subnet
- Network Security Group

## CI/CD
GitHub Actions validates:
- Bicep build
- Terraform format
- Terraform validate

## Final Working Flows

VM Creation:
Runbook → Download ARM JSON from Blob → Deploy VM from Golden Image

VM Operations:
Runbook → Azure VM Start/Stop action → Result output

Temp Cleanup:
Runbook → Azure Run Command → PowerShell cleanup inside VM → Result output

## Future Scope
- Connect Runbooks to Microsoft Teams chatbot
- Add OpenAI-based SOP recommendation
- Add RAG for SOP documents
- Add Azure Monitor disk usage query
- Add approval workflow before remediation
- Add chatbot flow for VM creation using user-provided hostname, location, and VM size