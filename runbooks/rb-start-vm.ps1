param(
    [string]$VmName,
    [string]$ResourceGroupName = "rg-infra-lab"
)

$ErrorActionPreference = "Stop"

# Login using Automation Account Managed Identity
Connect-AzAccount -Identity

Write-Output "Starting VM: $VmName"

Start-AzVM `
    -ResourceGroupName $ResourceGroupName `
    -Name $VmName

Write-Output "$VmName started successfully"