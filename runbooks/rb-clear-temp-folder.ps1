param(
    [string]$VmName,
    [string]$ResourceGroupName = "rg-infra-lab",
    [string]$FolderPath = "C:\Temp"
)

$ErrorActionPreference = "Stop"

# Login using Automation Account Managed Identity
Connect-AzAccount -Identity

Write-Output "Starting cleanup on VM: $VmName"
Write-Output "Target folder: $FolderPath"

# Script that will run inside the target VM
$Script = @"
if (Test-Path '$FolderPath') {
    Get-ChildItem -Path '$FolderPath' -Recurse -Force | Remove-Item -Recurse -Force
    Write-Output 'Cleanup completed successfully.'
} else {
    Write-Output 'Folder does not exist.'
}
"@

# Execute script inside Azure VM using Run Command
$Result = Invoke-AzVMRunCommand `
    -ResourceGroupName $ResourceGroupName `
    -VMName $VmName `
    -CommandId 'RunPowerShellScript' `
    -ScriptString $Script

# Show result
$Result.Value.Message

Write-Output "Cleanup runbook completed for VM: $VmName"