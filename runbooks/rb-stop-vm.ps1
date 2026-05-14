param(
    [string]$VmName,
    [string]$ResourceGroupName = "rg-infra-lab"
)

$ErrorActionPreference = "Stop"

# Login using Automation Account Managed Identity
Connect-AzAccount -Identity

Write-Output "Stopping VM: $VmName"

Stop-AzVM `
    -ResourceGroupName $ResourceGroupName `
    -Name $VmName `
    -Force

Write-Output "$VmName stopped successfully"