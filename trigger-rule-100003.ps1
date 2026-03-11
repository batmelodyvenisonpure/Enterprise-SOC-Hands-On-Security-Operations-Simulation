# trigger-rule-100003.ps1
Write-Host "Triggering Rule 100003: Windows Defender Disable (T1562.001)" -ForegroundColor Cyan
Write-Host "WARNING: This test DISABLES Windows Defender!" -ForegroundColor Red
Write-Host "It also disables Sysmon and other security features!" -ForegroundColor Red
Write-Host "Run only if you have a VM Snapshot." -ForegroundColor Red

# Bypassing Execution Policy
Write-Host "Bypassing Execution Policy." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force

$confirmation = Read-Host "Do you have a VM snapshot? (yes/no)"
if ($confirmation -ne 'yes') { exit }

$confirmation2 = Read-Host "Are you absolutely sure? (yes/no)"
if ($confirmation2 -ne 'yes') { exit }

Write-Host "Running Atomic Red Team test for T1562.001" -ForegroundColor Yellow
Invoke-AtomicTest T1562.001

Write-Host "Atomic test completed. The alert will not be present in Wazuh as Sysmon and other security features are disabled or corrupted." -ForegroundColor Green
Write-Host "Restore the VM snapshot to roll back the script's execution." -ForegroundColor Red
